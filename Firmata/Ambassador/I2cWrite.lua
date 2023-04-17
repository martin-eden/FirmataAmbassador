--[[
  Write to I2C device.

  Format:

    Request
    ~~~~~~~
      DeviceId - Byte
      Offset - Byte or Null
      Data - array of Byte
]]

local GenerateSysex = request('Handy.GenerateSysex')
local IsStringResponse = request('Handy.IsStringResponse')
local EncodeByte = request('Handy.EncodeByte')
local EncodeBytes = request('Handy.EncodeBytes')

local Flatten = request('!.table.unfold')

return
  function(self, Request)
    assert_table(Request)
    assert_integer(Request.DeviceId)
    assert(is_integer(Request.Offset) or is_nil(Request.Offset))
    assert_table(Request.Data)

    local DeviceId = Request.DeviceId
    local Offset = Request.Offset or 0

    if not self.IsI2cInitialized then
      self:InitializeI2c()
    end

    local ModeByte = 0

    local Command =
      {
        0x76,
        DeviceId,
        ModeByte,
        EncodeByte(Offset),
        EncodeBytes(Request.Data),
      }

    Command = Flatten(Command)

    Command = GenerateSysex(table.unpack(Command))

    self:Send(Command)
  end
