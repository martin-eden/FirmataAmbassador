--[[
  Connect to USB port given by name. If there is no Firmata, disconnect.

  Input

    PortName - String - port name like '/dev/ttyUSB0'

  Output

    TRUE - connected, port is opened
    OR
    NIL - failed to connect, port is closed

  Note

    There is dreaded case when there IS Firmata and she is sending
    continuous digital/analog/I2C/whatever reports. In my cases she
    will not react even to Reset command.

    If we don't receiving greeting messages after opening port,
    we are sending Reset (0xFF) command and disconnecting.
    In hopes for good behavior in next session.
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
