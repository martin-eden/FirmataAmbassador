--[[
  Connect to USB port given by name. If there is no Firmata, disconnect.

  There is dreaded case when there IS Firmata and she is sending
  continious digital/analog/I2C/whatever reports. In my cases she will
  not react even to Reset command.

  If we didn't receive greetings messages after opening port,
  we will send Reset command (0xFF) and disconnect.

  Returns
    TRUE - connected, port is opened
    NIL - failed to connect, port is closed
]]

return
  function(self, PortName)
    local Connector = self.Connector

    Connector:ConnectTo(PortName)

    if not Connector.IsConnected then
      Complain(('Failed to connect to "%s".'):format(PortName))
      return
    end

    self.Transmitter.GetByte = Connector.GetByte
    self.Transmitter.PutByte = Connector.PutByte

    local GotGreetings = self:GotInitGreetings()

    if not GotGreetings then
      Complain("Didn't get proper greetings from board.");
      self:Reset()
      self:Disconnect()
      return
    end

    return true
  end
