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
  function(self, Message)
    assert_byte(Message.Pin)
    assert_float(Message.Value)
    assert(
      (Message.Value >= 0.0) and (Message.Value < 1.0),
      'Value should be between [0.0, 1.0).'
      )

    -- Map [0.0, 1.0) to [0, 255].
    local PinValue = (Message.Value * 256) // 1 | 0

    local PinModeOutput = 3

    self:CompileAndSend('SetPinMode', { Pin = Message.Pin, Mode = PinModeOutput })
    self:CompileAndSend('SetPinValueLong', { Pin = Message.Pin, Value = PinValue })
  end
