--[[
  Parses Firmata message.

    Message
    ~~~~~~~
      IsSysex - Bool
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
      self:Complain(('No handler for message %s.'):format(RepresentMessage(Message)))
      return
    end

    local Result = self:RunHandler(Message, Handler)
    if not is_table(Result) then
      self:Complain(('Failed to parse message %s.'):format(RepresentMessage(Message)))
      return
    end

    return Result
  end
