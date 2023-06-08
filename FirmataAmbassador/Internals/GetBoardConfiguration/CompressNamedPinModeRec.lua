--[[
  Shrinking mapping of common pin modes.

  Convert

    {
      ...,
      ['Digital input'] = true, ['Digital input-pullup'] = true,
      ['Digital output'] = true, ['Servo'] = true,
      ['Analog input'] = true,
      PWM = false,
      ...,
    }

  to

    {
      ...,
      DIO = true,
      AI = true,
      -- no records for False values
      ...,
    }
]]

return
  function(NamedPinModeRec)
    assert_table(NamedPinModeRec)

    local Result = {}

    if
      (
        NamedPinModeRec['Digital input'] and
        NamedPinModeRec['Digital input-pullup'] and
        NamedPinModeRec['Digital output'] and
        NamedPinModeRec['Servo']
      )
    then
      Result.DIO = true
    end

    if NamedPinModeRec['Analog input'] then
      Result.AI = true
    end

    if NamedPinModeRec.PWM then
      Result.PWM = true
    end

    if NamedPinModeRec.I2C then
      Result.I2C = true
    end

    return Result
  end
