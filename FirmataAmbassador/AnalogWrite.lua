--[[
  PWM write to pin.

  Input

    {
      Pin - Byte
      Value - Float - clamped to range [0.0, 1.0]
    }

  Output

    none

  Note

    It's not analog write. Arduino Uno can't actually output stable
    voltage between 0V and 5V to pin (some other boards can).
    What it can do is to do PWM-output to pin (PWM freq is near 490Hz).
]]

local assert_byte = request('!.number.assert_byte')

return
  function(self, Request)
    assert_table(Request)
    assert_byte(Request.Pin)
    assert_float(Request.Value)

    local PinValue = Request.Value

    -- Clamp to [0.0, 1.0):
    PinValue = math.max(PinValue, 0.0)
    PinValue = math.min(PinValue, 1.0 - 1 / 512)

    -- Map [0.0, 1.0) to [0, 255]:
    PinValue = (PinValue * 256) // 1 | 0

    assert((PinValue >= 0) and (PinValue <= 255), PinValue)

    local PinModeOutput = 3

    self:CompileAndSend('SetPinMode', { Pin = Request.Pin, Mode = PinModeOutput })
    self:CompileAndSend('SetPinValueLong', { Pin = Request.Pin, Value = PinValue })
  end
