--[[
  Disable analog pin value reporting.

  Request
  ~~~~~~~
    Pin - Byte - pin number, 0 for A0 and so on
]]

local SetupAnalogPinReporting = request('SetupAnalogPinReporting')

return
  function(Request)
    assert_table(Request)

    Request.Enable = false

    return SetupAnalogPinReporting(Request)
  end
