--[[
  Get pin role based on supported pin modes.

  Input

    {
      ...,
      ? ['Digital input'] = true, ['Digital input-pullup'] = true,
      ? ['Digital output'] = true, ['Servo'] = true,
      ? ['Analog input'] = true,
      ? PWM = false,
      ...,
    }

  Output

    {
      ...,
      ? DIO = true,
      ? AI = true,
      -- no records for False values
      ...,
    }


  Note

    Abstractly it's shrinking mapping of common pin modes.

  Note

    Pin modes reported by Firmata are outrageously redundant.

    For common digital IO pin modes reported are "Digital input", "Digital
    input-pullup", "Digital output" and "Servo".

    For exploration reasons I want to see just want to see "DIO".
]]

return
  function(NamedPinModesRec)
    assert_table(NamedPinModesRec)

    local Result = {}

    if
      (
        NamedPinModesRec['Digital input'] and
        NamedPinModesRec['Digital input-pullup'] and
        NamedPinModesRec['Digital output'] and
        NamedPinModesRec['Servo']
      )
    then
      Result.DIO = true
    end

    if NamedPinModesRec['Analog input'] then
      Result.AI = true
    end

    if NamedPinModesRec.PWM then
      Result.PWM = true
    end

    if NamedPinModesRec.I2C then
      Result.I2C = true
    end

    return Result
  end
