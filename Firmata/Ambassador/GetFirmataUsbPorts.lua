--[[
  Returns a table with list of ports where Firmata is recognized.

  OS: GNU/Linux

  Iterates over each name from /dev/ttyUSB0 to /dev/ttyUSB7.
  If given "file" exists, opens it and checks if there are
  Firmata firmware for dialogue. If not, continues iteration.
]]

local UsbPortsIterator = request('Handy.UsbPortsIterator')

return
  function(self)
    local Result = {}

    for PortName in UsbPortsIterator() do
      if self:ConnectTo(PortName) then
        table.insert(Result, PortName)
        self:Disconnect()
      end
    end

    return Result
  end
