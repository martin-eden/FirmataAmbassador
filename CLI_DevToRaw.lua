--[[
  Command-line tool to

    1. Connect to Arduino device USB port.
    2. Get state if connected RTC DS3231 module.
    3. Save state in raw form to file.

  Usage:

    $ lua CLI_RawToDev.lua
]]

--[[
  Status: working with mocks
  Version: 1
  Last mod.: 2023-04-13
]]

package.path = package.path .. ';../../../?.lua'
require('workshop.base')

local Firmata = request('Firmata.Ambassador.Interface')

Firmata:Connect()
Firmata:Disconnect()
