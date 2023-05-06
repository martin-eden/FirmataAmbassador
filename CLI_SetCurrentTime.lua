#!/bin/lua

--[[
  Command-line tool to

    1. Load file with parsed state or RTC DS3231 module.
    2. Modify state by setting current date-time.
    3. Save parsed state to file.

  Usage:

    $ lua CLI_SetCurrentTime.lua
]]

--[[
  Status: works
  Version: 1
  Last mod.: 2023-05-06
]]

package.path = package.path .. ';../../../?.lua'
require('workshop.base')

local InputFileName = 'Result.Parsed.json'
local OutputFileName = 'Result.Parsed.json'

local StringFromFile = request('!.file.as_string')
local ParseJson = request('!.concepts.json.load')
local CompileJson = request('!.concepts.json.save')
local StringToFile = request('!.string.save_to_file')

local MergeTable = request('!.table.merge')

local CreateTimeRecord =
  function(CurrentTime)
    local TimeTable = os.date('*t', CurrentTime)

    -- <.wday> == 1 is Sunday. We want 1 to be Monday.
    local DayOfWeek = TimeTable.wday
    assert(DayOfWeek >= 1)
    DayOfWeek = DayOfWeek - 1
    if (DayOfWeek == 0) then
      DayOfWeek = 7
    end

    return
      {
        year = TimeTable.year,
        month = TimeTable.month,
        dow = DayOfWeek,
        date = TimeTable.day,
        hour = TimeTable.hour,
        minute = TimeTable.min,
        second = TimeTable.sec,
      }
  end

local SetCurrentTime =
  function(Rtc)
    local round_trip_time_sec = 2
    local CurrentTime = os.time() + round_trip_time_sec

    local Time = CreateTimeRecord(CurrentTime)

    MergeTable(Rtc.moment, Time)
    Rtc.at_battery.clock_was_stopped = false
  end

local RtcJson, Rtc

RtcJson = StringFromFile(InputFileName)
Rtc = ParseJson(RtcJson)
SetCurrentTime(Rtc)
RtcJson = CompileJson(Rtc)
StringToFile(OutputFileName, RtcJson)
