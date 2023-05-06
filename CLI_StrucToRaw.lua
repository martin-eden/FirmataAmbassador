#!/bin/lua

--[[
  Command-line tool to

    1. Load file with parsed state or RTC DS3231 module.
    2. Compile state to raw format.
    3. Save raw state to file.

  Usage:

    $ lua CLI_StrucToRaw.lua
]]

--[[
  Status: works
  Version: 1
  Last mod.: 2023-05-06
]]

package.path = package.path .. ';../../../?.lua'
require('workshop.base')

local InputFileName = 'Result.Parsed.json'
local OutputFileName = 'Result.Raw.json'

local FileToString = request('!.file.as_string')
local ParseJson = request('!.concepts.json.load')
local CompileToRawStruc = request('!.concepts.rtc_ds3231.compile')
local TableToJson = request('!.concepts.json.save')
local StringToFile = request('!.string.save_to_file')

local StrucJsonStr = FileToString(InputFileName)
local Struc = ParseJson(StrucJsonStr)
local RawStruc = CompileToRawStruc(Struc)

local Command =
  {
    Data = RawStruc,
    DeviceId = 0x68,
    Offset = 0,
    Type = 'I2C data',
  }

local RawJsonStr = TableToJson(Command)
StringToFile(OutputFileName, RawJsonStr)
