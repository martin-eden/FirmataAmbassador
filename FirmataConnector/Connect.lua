--[[
  OS: GNU/Linux

  Iterates over each name from /dev/ttyUSB0 to /dev/ttyUSB7.
  If given "file" exists, opens it and checks if there are
  Firmata firmware for dialogue. If not, continues iteration.
]]

local UsbPortsIterator = request('UsbPortsIterator')

return
  function(self, aPortName)
    if (is_string(aPortName)) then
      self.PortName = aPortName
    else
      for PortName in UsbPortsIterator() do
        self.PortName = PortName
        self:OpenPort()
        print(('Opened port %s.'):format(self.PortName))

        local IsFirmata = self:CheckItIsFirmata()
        if (not IsFirmata) then
          print('No Firmata protocol. Sorry.')
        else
          print('WHOA! Firmata!')
          break
        end
      end
    end

    if (is_nil(self.PortName)) then
      print('No open USB port was found.')
      return
    end

    self.IsConnected = true

    print('Connected.')
  end
