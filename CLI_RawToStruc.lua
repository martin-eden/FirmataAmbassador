#!/bin/lua

--[[
  Command-line tool to

    1. Load file with raw state or RTC DS3231 module.
    2. Parse state.
    3. Save parsed state to file.

  Usage:

    $ lua CLI_RawToStruc.lua
]]

--[[
  Status: works
  Version: 1
  Last mod.: 2023-05-06
]]

package.path = package.path .. ';../../../?.lua'
require('workshop.base')

local InputFileName = 'Result.Raw.json'
local OutputFileName = 'Result.Parsed.json'

local FileToString = request('!.file.as_string')
local ParseJson = request('!.concepts.json.load')
local ParseRawStruc = request('!.concepts.rtc_ds3231.parse')
local TableToJson = request('!.concepts.json.save')
local StringToFile = request('!.string.save_to_file')

local RawJsonStr = FileToString(InputFileName)
local RawStruc = ParseJson(RawJsonStr)
table.move(RawStruc.Data, 1, #RawStruc.Data, 0)
local ParsedStruc = ParseRawStruc(RawStruc.Data)
local ParsedJsonStr = TableToJson(ParsedStruc)
StringToFile(OutputFileName, ParsedJsonStr)
