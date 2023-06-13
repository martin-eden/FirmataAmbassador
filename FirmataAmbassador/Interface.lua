--[[
  FirmataAmbassador library public interface.
]]

-- For sure definition of global function will be removed from here.
-- Error output function. Feel free to redefine.
_G.Complain = function(Msg) print(Msg) end

local Internals = request('Internals.Interface')
local MergeTable = request('!.table.merge')

local Result =
  {
    -- Connection management:
    ConnectTo = request('ConnectTo'),
    Disconnect = request('Disconnect'),
    IsConnected = function(self) return self.Connector.IsConnected end,
    GetPortName = function(self) return self.Connector.PortName end,

    -- Main functions:
    DigitalRead = request('DigitalRead'),
    DigitalWrite = request('DigitalWrite'),
    AnalogRead = request('AnalogRead'),
    AnalogWrite = request('AnalogWrite'),
    I2cRead = request('I2cRead'),
    I2cWrite = request('I2cWrite'),
  }

MergeTable(Result, Internals)

return Result
