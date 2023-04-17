--[[
  Firmata message parser.

  Message
  ~~~~~~~
    Command - Byte
    Data - array of Byte
    IsSysex - Bool
]]

local assert_byte = request('!.number.assert_byte')

local Handlers = request('ByteHandlers.Interface')
local SysexHandlers = request('ByteHandlers.Sysex.Interface')

return
  function(self, Message)
    assert_table(Message)
    assert_byte(Message.Command)
    assert_table(Message.Data)
    assert_boolean(Message.IsSysex)

    local Result

    local Handler

    if Message.IsSysex then
      Handler = SysexHandlers[Message.Command]
    else
      Handler = Handlers[Message.Command]
    end

    if Handler then
      local HandlerResult = Handler(Message.Data)
      if is_table(HandlerResult) then
        Result = HandlerResult
      end
    end

    return Result
  end
