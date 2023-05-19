local PinModeNames = request('PinModeNames')

local GetPinModeName =
  function(PinMode)
    assert_integer(PinMode)

    local Result = PinModeNames[PinMode]

    if is_nil(Result) then
      Complain(('Unknown pin mode: %d.'):format(PinMode.Mode))
      return
    end

    return Result
  end

return GetPinModeName
