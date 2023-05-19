return
  function(Word)
    assert_integer(Word)

    assert(
      (Word >= 0) and (Word < (1 << 14)),
      'Value should fit in 14 bits.'
    )

    local Value1 = Word & 0x7F
    local Value2 = Word >> 7

    return { Value1, Value2 }
  end
