--[[
  OS: GNU/Linux

  Iterates over each name from /dev/ttyUSB0 to /dev/ttyUSB7.
  If given "file" exists, opens it and checks if there are
  Firmata firmware for dialogue. If not, continues iteration.
]]

local UsbPortsIterator = request('UsbPortsIterator')

return
  function(self)
    local Connector = self.Connector
    for PortName in UsbPortsIterator() do
      Connector:Connect(PortName)
      if self:CheckItIsFirmata() then
        print('Looks like Firmata.')
        break
      else
        print('Not like Firmata. Trying next port.')
      end
    end
  end
