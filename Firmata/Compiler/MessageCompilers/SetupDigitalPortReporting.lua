--[[
  Enable or disable digital port value reporting.

  Request
  ~~~~~~~
    Port - Byte - port number, 0 for pins 0..7, 1 for pins 8..15, ...
    Enable - Bool - FALSE to disable
]]

local CmdSetupDigitalPortReporting = request('^.^.Markers').SetupDigitalPortReporting

local assert_byte = request('!.number.assert_byte')

return
  function(Request)
    assert_table(Request)
    assert_byte(Request.Port)
    assert_boolean(Request.Enable)

    local EnableDisable = (Request.Enable and 1) or 0

    return
      {
        Command = CmdSetupDigitalPortReporting[Request.Port],
        IsSysex = false,
        Data = { EnableDisable },
      }
  end
