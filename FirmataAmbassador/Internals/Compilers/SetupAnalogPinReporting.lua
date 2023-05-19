--[[
  Enable or disable analog pin value reporting.

  Request
  ~~~~~~~
    Pin - Byte - pin number, 0 for A0 and so on
    Enable - Bool - FALSE to disable
]]

local SetupAnalogPinReportingCmds = request('^.Markers').SetupAnalogPinReporting

local assert_byte = request('!.number.assert_byte')

return
  function(Request)
    assert_table(Request)
    assert_byte(Request.Pin)
    assert_boolean(Request.Enable)

    local EnableDisable = (Request.Enable and 1) or 0

    return
      {
        Command = SetupAnalogPinReportingCmds[Request.Pin],
        Data = { EnableDisable },
      }
  end
