--[[
  Disconnect from USB port.
]]

return
  function(self)
    if not self.Connector.IsConnected then
      -- print('Not connected.')
    else
      local Result

      Result = self.Connector:Disconnect()

      if not Result then
        -- print('? Disconnect error ?')
      else
        self.Transmitter.GetByte = self.Connector.GetByte
        self.Transmitter.PutByte = self.Connector.PutByte

        -- print('Disconnected.')
      end

      return Result
    end
  end
