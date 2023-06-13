--[[
  Write to I2C device.

  Input

    {
      DeviceId - Byte
      [ Offset - Byte - Default: 0 ]
      Data - array of Byte
    }

  Output

    none
]]

local IsStringResponse = request('Internals.Handy.IsStringResponse')

return
  function(self, Request)
    if not self.IsI2cInitialized then
      self:I2cInit()
    end

    self:CompileAndSend('I2cWrite', Request)
  end
