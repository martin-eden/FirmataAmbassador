--[[
  Get pin mode name.

  Input

    PinMode - Byte - pin mode number

  Output

    String

    OR

    NIL - in case of unknown mode
]]

--[[
  Mapping of pin modes to mode names.
]]

local PinModesNames =
  {
    [0] = 'Digital input',
    [1] = 'Digital output',
    [2] = 'Analog input',
    [3] = 'PWM',
    [4] = 'Servo',
    [6] = 'I2C',
    [10] = 'Serial',
    [11] = 'Digital input-pullup',
  }

return
  function(PinMode)
    assert_integer(PinMode)

    local Result = PinModesNames[PinMode]

    return Result
  end
