#!/bin/lua

--[[
  Command-line tool to

    1. Connect to Arduino device USB port.
    2. Get state of connected RTC DS3231 module.
    3. Save state in raw form to file.

  Usage:

    $ lua CLI_DevToRaw.lua
]]

--[[
  Status: works
  Version: 3
  Last mod.: 2023-05-09
]]

package.path = package.path .. ';../../../?.lua'
require('workshop.base')

local Firmata = request('Firmata.Ambassador.Interface')
local TableToJson = request('!.concepts.json.save')
local StringToFile = request('!.string.save_to_file')

local PortName = '/dev/ttyUSB0'
local OutputFileName = 'Result.Raw.json'

local I2cRequest =
  {
    DeviceId = 0x68,
    Offset = 0x00,
    NumBytes = 0x13,
  }

if Firmata:ConnectTo(PortName) then
  local I2cResponse = Firmata:I2cRead(I2cRequest)
  StringToFile(OutputFileName, TableToJson(I2cResponse))
  Firmata:Disconnect()
else
  print(('Invalid port name or no Firmata there. (PortName: "%s").'):format(PortName))
end
