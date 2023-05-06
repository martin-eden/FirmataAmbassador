local assert_byte = request('!.number.assert_byte')

return
  function(self, Message)
    assert_table(self.SysexHandlers)
    assert_table(self.BaseHandlers)

    assert_boolean(Message.IsSysex)
    assert_byte(Message.Command)

    local Result

    if Message.IsSysex then
      Result = self.SysexHandlers[Message.Command]
    else
      Result = self.BaseHandlers[Message.Command]
    end

    return Result
  end
