#!/bin/lua

--[[
  Command-line tool to test general functionality of my Firmata library.

  Usage:

    $ lua CLI_SmokeTest.lua
]]

--[[
  Status: works
  Version: 3
  Last mod.: 2023-05-14
]]

package.path = package.path .. ';../../../?.lua'
require('workshop.base')

local Firmata = request('Firmata.Ambassador.Interface')

local GetResponseRepresentation = request('Handy.GetResponseRepresentation')

local SleepSec = request('!.system.sleep')

local Represent =
  function(Header, Message)
    print(Header .. ':')
    print(GetResponseRepresentation(Message))
  end

local PortName = '/dev/ttyUSB0'

-- [[
do
  local FirmataPorts = Firmata:GetFirmataUsbPorts()
  Represent('USB ports with Firmata', FirmataPorts)

  if (#FirmataPorts == 0) then
    print('No ports with Firmata. Quiting.')
    return
  end
end
--]]

do
  print(('Connecting to port "%s".'):format(PortName))
  Firmata:ConnectTo(PortName)
end

-- [[
do
  local I2cDevices = Firmata:GetOpenedI2cPorts()
  Represent('I2C devices', I2cDevices)
end
--]]

-- [[
do
  local Version = Firmata:GetVersion()
  Represent('Version', Version)
end
--]]

-- [[
do
  local VersionAndFirmware = Firmata:GetVersionAndName()
  Represent('Version and firmware', VersionAndFirmware)
end
-- ]]

-- [[
do
  print('Digital reads.')
  for pin = 0, 13 do
    print(('Pin %d: %s.'):format(pin, Firmata:DigitalRead({Pin = pin})))
  end
end
--]]

-- [[
do
  print('Analog reads.')
  for pin = 0, 5 do
    print(('A%d: %.2f'):format(pin, Firmata:AnalogRead({Pin = pin}) or -1))
  end
end
--]]

-- [[
do
  print('Digital writes.')
  for i = 1, 5 do
    Firmata:DigitalWrite({Pin = 13, Value = true})
    print('Tic.')
    SleepSec(0.5)
    Firmata:DigitalWrite({Pin = 13, Value = false})
    print('Tac.')
    SleepSec(0.5)
  end
end
--]]

-- [[
do
  print('Analog (PWM) write.')

  local Pin = 3

  print(('Using pin %d for PWM output.'):format(Pin))

  local N = 16
  for i = 1, N do
    local Value = (i / N) - 1 / 512
    print(('[%d / %d]: %.2f'):format(i, N, Value))
    Firmata:AnalogWrite({Pin = Pin, Value = Value})
    SleepSec(.1)
  end
  SleepSec(1.5)
  Firmata:AnalogWrite({Pin = Pin, Value = 0.0})
end
--]]

print('Disconnected.')
Firmata:Disconnect()
