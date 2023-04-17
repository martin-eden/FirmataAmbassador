--[[
  Connect to USB port given by name.
]]

return
  function(self, PortName)
    -- print(('Connecting to port "%s".'):format(PortName))

    if self:IsConnected() then
      -- print('Already connected.')
      self:Disconnect()
    end

    local Result

    local Connector = self.Connector
    Result = Connector:ConnectTo(PortName)

    if not Result then
      -- print('Not connected.')
    else
      -- print('Connected.')

      self.Transmitter.GetByte = self.Connector.GetByte
      self.Transmitter.PutByte = self.Connector.PutByte

      Result = self:CheckItIsFirmata()
      if not Result then
        self:Disconnect()
      end
    end

    return Result
  end
