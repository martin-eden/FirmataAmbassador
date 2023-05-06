--[[
  I2C read.

  Request
  ~~~~~~~
    DeviceId - Byte - 7-bit device address
    NumBytes - Byte - num bytes to read
    [Offset - Byte, Default: 0] - offset to start reading
]]

local CmdI2cReadWrite = request('^.^.^.Markers').Sysex.I2cReadWrite

local EncodeByte = request('Handy.EncodeByte')
local Flatten = request('!.table.unfold')

return
  function(Request)
    assert_table(Request)
    assert_integer(Request.DeviceId)
    assert_integer(Request.NumBytes)
    assert(is_integer(Request.Offset) or is_nil(Request.Offset))

    local DeviceId = Request.DeviceId
    local NumBytes = Request.NumBytes
    local Offset = Request.Offset or 0

    local ModeByte = (1 << 3)

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
              EncodeByte(NumBytes),
            }
          )
      }
  end
