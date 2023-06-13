--[[
  Request state of specified pin.

  Input

    Request
    ~~~~~~~
      Pin - Byte

  Output

    Standard output for [Transmitter.Send()].
]]

local RequestPinState = request('^.Markers').PinStateRq
local assert_byte = request('!.number.assert_byte')

return
  function(Request)
    assert_table(Request)
    assert_byte(Request.Pin)

    return
      {
        Command = RequestPinState,
        Data = { Request.Pin },
      }
  end
