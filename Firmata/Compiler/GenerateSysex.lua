local assert_byte = request('!.number.assert_byte')

local Markers = request('^.Markers')

return
  function(...)
    local NumArgs = select('#', ...)

    assert(NumArgs >= 1)
    for i = 1, NumArgs do
      local Term = select(i, ...)
      assert_byte(Term)
    end

    local Chars = {}
    table.insert(Chars, string.char(Markers.SysexStart))
    for i = 1, NumArgs do
      local Term = select(i, ...)
      table.insert(Chars, string.char(Term))
    end
    table.insert(Chars, string.char(Markers.SysexEnd))

    local Result = table.concat(Chars)

    return Result
  end
