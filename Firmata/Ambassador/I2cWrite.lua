--[[
  Write to I2C device.

  Format:

    Request
    ~~~~~~~
      DeviceId - Byte
      [ Offset - Byte, Default: 0 ]
      Data - array of Byte
]]

local CompileI2cWriteRequest = request('^.Compiler.MessageCompilers.Interface').I2cWrite
local IsStringResponse = request('Handy.IsStringResponse')

return
  function(self, Request)
    if not self.IsI2cInitialized then
      self:I2cInit()
    end

    local Command = CompileI2cWriteRequest(Request)

    self:Send(Command)
  end
