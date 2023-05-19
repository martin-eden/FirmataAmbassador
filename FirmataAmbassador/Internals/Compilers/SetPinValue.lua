--[[
  Set pin value.

  Request
  ~~~~~~~
    Pin - Byte
    Value - Byte (0/1 when port is digital output)
]]

local assert_byte = request('!.number.assert_byte')

local SetPinValueCmd = request('^.Markers').PinValue

return
  function(Request)
    assert_table(Request)
    assert_byte(Request.Pin)
    assert_byte(Request.Value)

    return
      {
        Command = SetPinValueCmd,
        Data =
          {
            Request.Pin,
            Request.Value,
          },
      }
  end
