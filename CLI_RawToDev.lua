#!/bin/lua

--[[
  Command-line tool to

    1. Connect to Arduino device USB port.
    2. Get state if connected RTC DS3231 module.
    3. Save state in raw form to file.

  Usage:

    $ lua CLI_RawToDev.lua
]]

--[[
  Status: works
  Version: 1
  Last mod.: 2023-05-06
]]

package.path = package.path .. ';../../../?.lua'
require('workshop.base')

local Firmata = request('Firmata.Ambassador.Interface')

local FileToString = request('!.file.as_string')
local ParseJson = request('!.concepts.json.load')

local PortName = '/dev/ttyUSB0'
local InputFileName = 'Result.Raw.json'

local I2cData = ParseJson(FileToString(InputFileName))

Firmata:ConnectTo(PortName)
Firmata:I2cWrite(I2cData)
Firmata:Disconnect()
