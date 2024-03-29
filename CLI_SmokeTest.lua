#!/bin/lua

--[[
  Command-line tool to test general functionality of my FirmataAmbassador
  library.

  Usage:

    $ lua CLI_SmokeTest.lua
]]

--[[
  Status: works
  Version: 6
  Last mod.: 2023-09-09
]]

-- Configuration:

local PortName = '/dev/ttyUSB0' -- Arduino Uno
-- local PortName = '/dev/ttyACM0' -- Arduino Mega

local TestsToRun =
  {
    -- GetVersion = true,
    -- GetVersionAndName = true,

    GetBoardConfiguration = true,

    DigitalRead = true,
    DigitalWrite = true,
    AnalogRead = true,
    AnalogWrite = true,
  }

-- Implementation:

package.path = package.path .. ';../../../?.lua'
require('workshop.base')

local Firmata = request('FirmataAmbassador.Interface')

local GetResponseRepresentation = request('Handy.GetResponseRepresentation')
local t2s = request('!.table.as_string')

local SleepSec = request('!.system.sleep')

local Represent =
  function(Header, Message)
    print(Header .. ':')
    print(GetResponseRepresentation(Message))
  end

local RunTests =
  function(TestsToRun)
    if TestsToRun.GetVersion then
      local Version = Firmata:GetVersion()
      Represent('Version', Version)
    end

    if TestsToRun.GetVersionAndName then
      local VersionAndFirmware = Firmata:GetVersionAndName()
      Represent('Version and firmware', VersionAndFirmware)
    end

    if TestsToRun.GetBoardConfiguration then
      print('Getting board configuration.')
      local BoardConfiguration = Firmata:GetBoardConfiguration()
      if BoardConfiguration then
        -- Represent('', BoardConfiguration)
        print(t2s(BoardConfiguration))
      end
    end

    if TestsToRun.DigitalRead then
      print('Digital reads.')
      for pin = 0, 13 do
        print(('Pin %d: %s.'):format(pin, Firmata:DigitalRead(pin)))
      end
    end

    if TestsToRun.DigitalWrite then
      print('Digital writes.')
      for i = 1, 5 do
        Firmata:DigitalWrite({Pin = 13, Value = true})
        print('Tic.')
        SleepSec(0.5)
        Firmata:DigitalWrite({Pin = 13, Value = false})
        print('Tac.')
        SleepSec(0.5)
      end
      Firmata:DigitalWrite({Pin = 10, Value = true})
    end

    if TestsToRun.AnalogRead then
      print('Analog reads.')
      for pin = 0, 5 do
        print(('A%d: %.2f'):format(pin, Firmata:AnalogRead(pin) or -1))
      end
    end

    if TestsToRun.AnalogWrite then
      print('Analog (PWM) writes.')

      local PwmPin = 3

      print(('Using pin %d for PWM output.'):format(PwmPin))

      local N = 16
      for AngleDeg = 0, 360, 10 do
        -- Map angle to [0.0, 1.0]:
        local Value = 0.5 + math.sin(math.rad(AngleDeg)) / 2

        print(('[%d deg]: %.2f'):format(AngleDeg, Value))
        Firmata:AnalogWrite({Pin = PwmPin, Value = Value})
        SleepSec(.1)
      end
      SleepSec(1.5)
      Firmata:AnalogWrite({Pin = PwmPin, Value = 0.0})
    end
end

print(('Connecting to port "%s".'):format(PortName))

if (not Firmata:ConnectTo(PortName)) then
  print(("Can't connect to Firmata on port %s."):format(PortName))
  return
end

RunTests(TestsToRun)

print('Disconnected.')
Firmata:Disconnect()
