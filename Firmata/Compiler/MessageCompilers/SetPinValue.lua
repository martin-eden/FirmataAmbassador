--[[
  Set pin value.

  Request
  ~~~~~~~
    Pin - Byte
    Value - Byte (0/1 when port is digital output)
]]

local assert_byte = request('!.number.assert_byte')

local SetPinValueRequest = request('^.^.Markers').PinValue

return
  function(Request)
    assert_table(Request)
    assert_byte(Request.Pin)
    assert_byte(Request.Value)

    return
      {
        IsSysex = false,
        Command = SetPinValueRequest,
        Data =
          {
            Request.Pin,
            Request.Value,
          },
      }
  end
