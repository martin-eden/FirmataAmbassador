--[[
  Enable digital port value reporting.

  Request
  ~~~~~~~
    Port - Byte - port number, 0 for pins 0..7, 1 for pins 8..15, ...
]]

local SetupDigitalPortReporting = request('SetupDigitalPortReporting')

return
  function(Request)
    assert_table(Request)

    Request.Enable = true

    return SetupDigitalPortReporting(Request)
  end
