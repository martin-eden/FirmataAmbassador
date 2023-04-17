local assert_byte = request('!.number.assert_byte')

local Markers = request('^.^.Markers')

return
  function(...)
    local NumArgs = select('#', ...)

    assert(NumArgs >= 1)
    for i = 1, NumArgs do
      local Term = select(i, ...)
      assert_byte(Term)
    end

    local Result = { Command = Markers.SysexStart }

    Result.Data = {}
    for i = 1, NumArgs do
      local Term = select(i, ...)
      table.insert(Result.Data, Term)
    end
    table.insert(Result.Data, Markers.SysexEnd)

    return Result
  end
