#!/bin/lua

--[[
  Just a LED13 blink test.
]]

--[[
  Status: works
  Version: 2
  Last mod.: 2023-05-13
]]

package.path = package.path .. ';../../../?.lua'
require('workshop.base')

local Firmata = request('Firmata.Ambassador.Interface')
local SleepSec = request('!.system.sleep')

local PortName = '/dev/ttyUSB0'

Firmata:ConnectTo(PortName)

for i = 1, 5 do
  Firmata:DigitalWrite({Pin = 13, Value = false})
  SleepSec(0.5)
  Firmata:DigitalWrite({Pin = 13, Value = true})
  SleepSec(0.5)
end

Firmata:Disconnect()
