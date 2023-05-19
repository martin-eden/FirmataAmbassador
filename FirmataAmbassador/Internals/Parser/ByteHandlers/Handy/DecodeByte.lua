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

    if (Value1 > 0x7F) or (Value2 > 0x01) then
      --[[
        Can't convert these values to byte.

        As we are typically called with input from communication
        channel, it means that one byte was lost. We want to give outer
        code a possibility to handle and recover, so we are not throwing
        error().
      ]]
      return
    end

    local Result = Value1 | (Value2 << 7)

    return Result
  end
