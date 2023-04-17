--[[
  Convert two 7-bit bytes from Firmata to one 8-bit byte.

  Arguments:
    Message - array of bytes
    StartIdx - index where pair of bytes starts

  Returns byte.
]]

local assert_byte = request('!.number.assert_byte')

return
  function(Message, StartIdx)
    assert_table(Message)
    assert_integer(StartIdx)

    local Value1, Value2 = Message[StartIdx], Message[StartIdx + 1]

    assert_byte(Value1)
    assert_byte(Value2)

    assert(Value1 <= 0x7F)
    assert(Value2 <= 0x01)

    local Result = Value1 | (Value2 << 7)

    return Result
  end
