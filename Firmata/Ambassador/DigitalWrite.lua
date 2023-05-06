--[[
  Set digital (boolean) value of pin.

  Effectively writes 0V or 5V to pin.

  Request
  ~~~~~~~
    Pin - Byte
    Value - Boolean
]]

local CompileSetPinMode = request('^.Compiler.MessageCompilers.Interface').SetPinMode
local CompileSetPinValue = request('^.Compiler.MessageCompilers.Interface').SetPinValue

local assert_byte = request('!.number.assert_byte')

return
  function(self, Request)
    assert_table(Request)
    assert_byte(Request.Pin)
    assert_boolean(Request.Value)

    local ByteValue = (Request.Value and 1) or 0

    self:Send(CompileSetPinMode({Pin = Request.Pin, Mode = 1}))
    self:Send(CompileSetPinValue({Pin = Request.Pin, Value = ByteValue}))
  end
