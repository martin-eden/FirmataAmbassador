--[[
  Convert two 7-bit bytes to one 14-bit word.

  Gets array of bytes, reads first two of them and returns word.

  Input

    Message - array of Byte

  Output

    Word (14 bits)
]]

local assert_byte = request('!.number.assert_byte')

return
  function(Message)
    assert_table(Message)

    local Value1, Value2 = Message[1], Message[2]

    assert_byte(Value1)
    assert_byte(Value2)

    assert(Value1 <= 0x7F)
    assert(Value2 <= 0x7F)

    local Result = (Value2 << 7) | Value1

    return Result
  end
