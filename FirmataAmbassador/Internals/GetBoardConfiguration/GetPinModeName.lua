--[[
  Get pin mode name.

  Input

    PinMode - Byte - pin mode number

  Output

    String
    OR
    NIL - in case of unknown mode
]]

local PinModeNames = request('PinModeNames')

return
  function(PinMode)
    assert_integer(PinMode)

    local Result = PinModeNames[PinMode]

    if is_nil(Result) then
      Complain(('Unknown pin mode: %d.'):format(PinMode.Mode))
      return
    end

    return Result
  end
