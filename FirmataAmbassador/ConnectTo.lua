--[[
  Connect to USB port given by name. If there is no Firmata, disconnect.

  There is dreaded case when there IS Firmata and she is sending
  continious digital/analog/I2C/whatever reports. In my cases she will
  not react even to Reset command.

  If we didn't receive greetings messages after opening port,
  we will send Reset command (0xFF) and disconnect.

  Returns
    TRUE - connected, port is opened
    FALSE - failed to connect, port is closed
]]

return
  function(self, PortName)
    -- print(('Connecting to port "%s".'):format(PortName))

    if self:IsConnected() then
      -- print('Already connected.')
      self:Disconnect()
    end

    local Connector = self.Connector

    Connector:ConnectTo(PortName)

    self.Transmitter.GetByte = Connector.GetByte
    self.Transmitter.PutByte = Connector.PutByte

    -- Connected.

    Result = self:GotInitGreetings()
    if not Result then
      self:Reset()
      self:Disconnect()
    end

    return Result
  end
