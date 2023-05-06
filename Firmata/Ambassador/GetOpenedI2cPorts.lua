--[[
  Get a list of connected I2C devices.

  Scans all 7-bit space for device id. Tries to read first byte from device.
  If there is no error, adds device id to result.

  Returns

    T
    ~
      DeviceId, ...
]]

return
  function(self)
    if not self:IsConnected() then
      -- Not connected.
      self:Complain('Not connected.')
      return
    end

    local Result = {}

    for DeviceId = 0x00, 0x7F do
      local ScanResult = self:I2cRead({DeviceId = DeviceId, NumBytes = 1})
      if not is_nil(ScanResult) then
        -- Live port.
        table.insert(Result, DeviceId)
      end
    end

    return Result
  end
