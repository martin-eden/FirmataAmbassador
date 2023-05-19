--[[
  Parses Firmata message.

    Message
    ~~~~~~~
      Command - Byte
      Data - array of Byte

  Result is table with data-dependent structure.
  If it's unable to parse message, returns nothing.
]]

local RepresentMessage =
  function(Message)
    return ('(SysEx: %s, Command: 0x%02X)'):format(Message.IsSysex, Message.Command)
  end

return
  function(self, Message)
    local Handler = self:GetHandler(Message)

    if not Handler then
      Complain(('No handler for message %s.'):format(RepresentMessage(Message)))
      return
    end

    local Result = self:RunHandler(Message, Handler)

    if not is_table(Result) then
      Complain(('Failed to parse message %s.'):format(RepresentMessage(Message)))
      return
    end

    return Result
  end
