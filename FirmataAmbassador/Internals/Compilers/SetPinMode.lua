--[[
  Set pin mode.

  Request
  ~~~~~~~
    Pin - Byte
    Mode - Byte (0 - input, 1 - output)
]]

local assert_byte = request('!.number.assert_byte')

local SetPinModeCmd = request('^.Markers').PinMode

return
  function(Request)
    assert_table(Request)
    assert_byte(Request.Pin)
    assert_byte(Request.Mode)

    return
      {
        Command = SetPinModeCmd,
        Data =
          {
            Request.Pin,
            Request.Mode,
          },
      }
  end
