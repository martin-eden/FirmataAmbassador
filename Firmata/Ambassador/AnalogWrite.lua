--[[
  PWM write to pin.

  Request
  ~~~~~~~
    Pin - Byte
    Value - Float - 0.0 < X <= 1.0


  It's not analog write. Arduino Uno can't actually output stable
  voltage between 0V and 5V to pin (some other boards can).
  What it can do is to do PWM-output to pin (with freq like 490Hz).
]]

local assert_byte = request('!.number.assert_byte')

local MessageCompiler = request('^.Compiler.MessageCompilers.Interface')
local CompileSetPinMode = MessageCompiler.SetPinMode
local CompileSetPinValueLong = MessageCompiler.SetPinValueLong

return
  function(self, Message)
    assert_byte(Message.Pin)
    assert_float(Message.Value)
    assert(
      (Message.Value >= 0.0) and (Message.Value < 1.0),
      'Value should be between [0.0, 1.0).'
      )

    local ActualWord = (Message.Value * 256) // 1 | 0

    self:Send(CompileSetPinMode({Pin = Message.Pin, Mode = 3}))
    self:Send(CompileSetPinValueLong({Pin = Message.Pin, Value = ActualWord}))
  end
