--[[
  Disconnect from USB port.
]]

return
  function(self)
    if not self.Connector.IsConnected then
      Complain('Not connected.')
      return
    end

    self.Connector:Disconnect()

    self.Transmitter.GetByte = nil
    self.Transmitter.PutByte = nil
  end
