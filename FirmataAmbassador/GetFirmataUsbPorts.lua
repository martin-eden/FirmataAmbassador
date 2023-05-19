--[[
  Returns a table with list of ports where Firmata is recognized.

  OS: GNU/Linux

  Iterates over each name from /dev/ttyUSB0 to /dev/ttyUSB7.
  If given "file" exists, opens it and checks if there are
  Firmata firmware for dialogue. If not, continues iteration.
]]

local UsbPortsIterator = request('Internals.Handy.UsbPortsIterator')

return
  function(self)
    local Result = {}

    local OriginalPortName = self:GetPortName()

    for PortName in UsbPortsIterator() do
      if self:ConnectTo(PortName) then
        table.insert(Result, PortName)
        self:Disconnect()
      end
    end

    if OriginalPortName then
      self:ConnectTo(OriginalPortName)
    end

    return Result
  end
