--[[
  Convert message to bytes and write to stream.

  Message
  ~~~~~~~
    Command - Byte
    [ Data - { Byte, ... } ]
]]

local assert_byte = request('!.number.assert_byte')

return
  function(self, Message)
    assert_table(Message)
    assert_byte(Message.Command)
    if not is_nil(Message.Data) then
      assert_table(Message.Data)
    end

    assert(is_function(self.PutByte), 'No function for PutByte().')

    self.PutByte(Message.Command)
    if Message.Data then
      for i = 1, #Message.Data do
        self.PutByte(Message.Data[i])
      end
    end
  end
