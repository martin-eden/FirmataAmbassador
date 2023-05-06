--[[
  I2C write.

  Request
  ~~~~~~~
    DeviceId - Byte - 7-bit device address
    Data - array of Byte - bytes to write
    [Offset - Byte, Default: 0] - offset to start writing
]]

local CmdI2cReadWrite = request('^.^.^.Markers').Sysex.I2cReadWrite

local EncodeByte = request('Handy.EncodeByte')
local EncodeBytes = request('Handy.EncodeBytes')
local Flatten = request('!.table.unfold')

return
  function(Request)
    assert_table(Request)
    assert_integer(Request.DeviceId)
    assert(is_integer(Request.Offset) or is_nil(Request.Offset))
    assert_table(Request.Data)

    local DeviceId = Request.DeviceId
    local Offset = Request.Offset or 0

    local ModeByte = 0

    return
      {
        IsSysex = true,
        Command = CmdI2cReadWrite,
        Data =
          Flatten(
            {
              DeviceId,
              ModeByte,
              EncodeByte(Offset),
              EncodeBytes(Request.Data),
            }
          )
      }
  end
