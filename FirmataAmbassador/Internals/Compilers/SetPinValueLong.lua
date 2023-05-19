--[[
  Set pin value to 14-bit word.

  Request
  ~~~~~~~
    Pin - Byte
    Value - Word (14 bits)
]]

local assert_byte = request('!.number.assert_byte')

local SetPinValueLong_cmd = request('^.Markers').PinLongValue
local EncodeWord = request('Handy.EncodeWord')
local Flatten = request('!.table.unfold')

return
  function(Message)
    assert_byte(Message.Pin)
    assert_integer(Message.Value)

    return
      {
        Command = SetPinValueLong_cmd,
        Data =
          Flatten(
            {
              Message.Pin,
              EncodeWord(Message.Value)
            }
          ),
      }
  end
