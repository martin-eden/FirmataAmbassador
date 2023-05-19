local assert_byte = request('!.number.assert_byte')

return
  function(self, Message)
    assert_table(self.ByteHandlers)
    assert_byte(Message.Command)

    local Result = self.ByteHandlers[Message.Command]

    return Result
  end
