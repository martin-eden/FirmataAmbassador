local assert_byte = request('!.number.assert_byte')

return
  function(Byte)
    assert_byte(Byte)

    local Value1 = Byte & 0x7F
    local Value2 = Byte >> 7

    return { Value1, Value2 }
  end
