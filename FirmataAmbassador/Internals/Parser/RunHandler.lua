local assert_byte = request('!.number.assert_byte')

return
  function(self, Message, Handler)
    assert_byte(Message.Command)
    assert_table(Message.Data)

    assert_function(Handler)

    local Result = Handler(Message.Command, Message.Data)
    if is_table(Result) then
      return Result
    end
  end
