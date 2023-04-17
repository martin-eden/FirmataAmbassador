--[[
  Skims input stream for Firmata message.

  Returns

    Message
    ~~~~~~~
      Command - Byte
      IsSysex - Bool
      [ Data - { Byte, ... } ]

  Message is not parsed, just framed.


  Rantings ahead.

  There are two types of messages:
    fixed-length and
    variable-length (aka Sysex)

  Variable-length is actually simple to parse. It's like getting
  data from parenthesis: "()(123)". Also parenthesis are balanced
  and not folded: not ")(", "())", "(())".

  Problem with fixed-length messages. Their format is

    ByteInRange(80, FF) ZeroOrMore(ByteInRange(00, 7F))
    ~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          Command                 Data

  Number of data bytes depends of <Command>.

  So if you want to write parser which reads exactly as many bytes
  as needed from stream, you need to know length of data part for
  each command.

  That's not what I like. I prefer formats where you can frame units
  without knowing there internal structure.

  For Firmata protocol version 2.6.0 there are plenty of holes in
  80..FF range which not have command.

  So your parser is not future-proof when parsing fixed-length messages.
  There can be new fixed-length message and you cannot frame it because
  you don't know length of data part.


  You can try to frame fixed-length message by reading data bytes
  until you will get command byte (range 80..FF).

  But you are reading from stream. So when you had read byte, you cannot
  put it back. So you need one-byte cache and only your reader should
  work with stream (because cached byte will be in your reader).

  Also there are no such thing as "end of stream". Only read timeout.

  So if you try to frame sequence like "AA 00 01", you will hit
  timeout before you can consider that byte "01" is last data byte
  of message.


  This implementation uses hardcoded knowledge of fixed-length messages
  format for Firmata protocol v2.6.0.

  This is ugly from universality point of view but I want to make
  function easy to use. It will always extract frame from input
  stream without reading more than needed. (Well, at least for v2.6.0.)
]]

local Signatures = request('^.Markers')

-- Hardcoded format knowledge for fixed-length messages.
local GetNumBytesToRead =
  function(Command)
    if (
      ((Command >= 0x90) and (Command <= 0x9F)) or
      ((Command >= 0xE0) and (Command <= 0xEF)) or
      (Command == 0xF4) or
      (Command == 0xF5) or
      (Command == 0xF9)
    ) then
      return 2
    end
  end

local IsCommandByte =
  function(Byte)
    return ((Byte >= 0x80) and (Byte <= 0xFF))
  end

return
  function(self)
    local ReadUntil =
      function(Condition, Result)
        while true do
          local Byte = self.GetByte()

          if is_nil(Byte) then
            -- No more data in stream so far.
            break
          end

          if is_table(Result) then
            table.insert(Result, Byte)
          end

          if
            (is_function(Condition) and Condition(Byte)) or
            (is_integer(Condition) and (Byte == Condition))
          then
            return Byte
          end
        end
      end

    local LastByte

    -- Skip data bytes at start.
    LastByte = ReadUntil(IsCommandByte)

    if is_nil(LastByte) then
      -- No command byte.
      return
    end

    local Result

    if (LastByte == Signatures.SysexStart) then
      -- Variable-length are easy.

      Result =
        {
          Command = nil,
          Data = {},
          IsSysex = true,
        }

      LastByte = ReadUntil(Signatures.SysexEnd, Result.Data)

      if is_nil(LastByte) then
        return
      end

      Result.Command = Result.Data[1]

      -- Remove Sysex frame bytes.
      table.remove(Result.Data, 1)
      table.remove(Result.Data)
    else
      Result =
        {
          Command = LastByte,
          Data = {},
          IsSysex = false,
        }

      local NumBytesToRead = GetNumBytesToRead(Result.Command)

      if is_nil(NumBytesToRead) then
        -- Unknown fixed-length command.
        local ErrorMsg = ('Unknown fixed-length command: [%02X].'):format(Result.Command)
        error(ErrorMsg)
      end

      for i = 1, NumBytesToRead do
        local Byte = self.GetByte()

        if is_nil(Byte) then
          -- Unexpected end.
          local ErrorMsg =
            ('Not enough data for command [%02X]. Expected %d bytes, read %d.'):
            format(Result.Command, NumBytesToRead, i)
          error(ErrorMsg)
        end

        table.insert(Result.Data, Byte)
      end
    end

    return Result
  end
