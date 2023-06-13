--[[
  Set digital (boolean) value of pin.

  Input

    {
      Pin - Byte
      Value - Boolean
    }

  Output

    none

  Note

    Effectively writes 0V (false) or 5V (true) to pin.
]]

local Compilers = request('Internals.Compilers.Interface')
local CompileSetPinMode = Compilers.SetPinMode
local CompileSetPinValue = Compilers.SetPinValue

local assert_byte = request('!.number.assert_byte')

return
  function(self, Request)
    assert_table(Request)
    assert_byte(Request.Pin)
    assert_boolean(Request.Value)

    local ByteValue = (Request.Value and 1) or 0

    local PinModeDigitalOutput = 1

    self:CompileAndSend('SetPinMode', { Pin = Request.Pin, Mode = PinModeDigitalOutput })
    self:CompileAndSend('SetPinValue', { Pin = Request.Pin, Value = ByteValue })
  end
