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
  Version: 2
  Last mod.: 2023-05-06
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

local RepresentI2cChunk =
  function(Chunk)
    assert(is_table(Chunk), 'No data.')
    assert_integer(Chunk.Offset)
    assert_integer(Chunk.DeviceId)
    assert_table(Chunk.Data)

    local Result

    Result = TableToJson(Chunk)

    return Result
  end

Firmata:ConnectTo(PortName)
local I2cResponse = Firmata:I2cRead(I2cRequest)
StringToFile(OutputFileName, RepresentI2cChunk(I2cResponse))
Firmata:Disconnect()
