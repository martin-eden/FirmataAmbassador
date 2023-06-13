--[[
  PWM write to pin.

  Request
  ~~~~~~~
    Pin - Byte
    Value - Float: >= 0.0 and < 1.0

  It's not analog write. Arduino Uno can't actually output stable
  voltage between 0V and 5V to pin (some other boards can).
  What it can do is to do PWM-output to pin (PWM freq is near 490Hz).
]]

local assert_byte = request('!.number.assert_byte')

return
  function(self, Request)
    assert_byte(Request.Pin)
    assert_float(Request.Value)
    assert(
      (Request.Value >= 0.0) and (Request.Value < 1.0),
      'Value should be between [0.0, 1.0).'
      )

    -- Map [0.0, 1.0) to [0, 255].
    local PinValue = (Request.Value * 256) // 1 | 0

    local PinModeOutput = 3

    self:CompileAndSend('SetPinMode', { Pin = Request.Pin, Mode = PinModeOutput })
    self:CompileAndSend('SetPinValueLong', { Pin = Request.Pin, Value = PinValue })
  end
