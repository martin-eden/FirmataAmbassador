return
  {
    I2cInit = request('Sysex.I2cInit'),
    I2cRead = request('Sysex.I2cRead'),
    I2cWrite = request('Sysex.I2cWrite'),

    SetPinMode = request('SetPinMode'),
    SetPinValue = request('SetPinValue'),
    SetPinValueLong = request('Sysex.SetPinValueLong'),

    EnableAnalogPinReporting = request('EnableAnalogPinReporting'),
    DisableAnalogPinReporting = request('DisableAnalogPinReporting'),
    SetupAnalogPinReporting = request('SetupAnalogPinReporting'),

    EnableDigitalPortReporting = request('EnableDigitalPortReporting'),
    DisableDigitalPortReporting = request('DisableDigitalPortReporting'),
    SetupDigitalPortReporting = request('SetupDigitalPortReporting'),

    Version = request('Version'),
    VersionAndName = request('Sysex.VersionAndName'),

    Reset = request('Reset'),
  }
