--[[
  Message compilers.

  Input:
    Table - implementation-specific format

  Output:
    Table:
      Command: Byte
      Data: array of Byte

  This is just collection of standalone functions. They do not
  expect object-oriented calls. Do not call as ":SetPinMode"
  do call as ".SetPinMode".
]]

return
  {
    I2cInit = request('I2cInit'),
    I2cRead = request('I2cRead'),
    I2cWrite = request('I2cWrite'),

    GetPinsModes = request('GetPinsModes'),
    GetPinState = request('GetPinState'),
    SetPinMode = request('SetPinMode'),
    SetPinValue = request('SetPinValue'),
    SetPinValueLong = request('SetPinValueLong'),

    EnableAnalogPinReporting = request('EnableAnalogPinReporting'),
    DisableAnalogPinReporting = request('DisableAnalogPinReporting'),
    SetupAnalogPinReporting = request('SetupAnalogPinReporting'),

    EnableDigitalPortReporting = request('EnableDigitalPortReporting'),
    DisableDigitalPortReporting = request('DisableDigitalPortReporting'),
    SetupDigitalPortReporting = request('SetupDigitalPortReporting'),

    Version = request('Version'),
    VersionAndName = request('VersionAndName'),

    Reset = request('Reset'),
  }
