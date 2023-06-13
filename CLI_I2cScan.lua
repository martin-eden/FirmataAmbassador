#!/bin/lua

--[[
  Get a list of connected I2C devices.

  Usage:

    $ lua CLI_I2cScan.lua
]]

--[[
  Status: works
  Version: 1
  Last mod.: 2023-06-13
]]

local PortName = '/dev/ttyUSB0'

package.path = package.path .. ';../../../?.lua'
require('workshop.base')

local Firmata = request('FirmataAmbassador.Interface')
local GetResponseRepresentation = request('Handy.GetResponseRepresentation')

--[[
  Scan all 7-bit space for device id. Try to read first byte from device.
  If there is no error, add device id to result.

  Input

    Firmata - Table - FimataAmassador object

  Output

    {
      DeviceId - Byte
      ...
    }
]]
local I2cScan =
  function(Firmata)
    local Result = {}

    for DeviceId = 0x00, 0x7F do
      local ScanResult = Firmata:I2cRead({ DeviceId = DeviceId, NumBytes = 1 })
      if not is_nil(ScanResult) then
        -- Live port.
        table.insert(Result, DeviceId)
      end
    end

    return Result
  end

local Represent =
  function(Header, Message)
    print(Header .. ':')
    print(GetResponseRepresentation(Message))
  end

Firmata:ConnectTo(PortName)

local I2cDevices = I2cScan(Firmata)

print(('Port "%s".'):format(Firmata:GetPortName()))
Represent('I2C devices found', I2cDevices)

Firmata:Disconnect()
