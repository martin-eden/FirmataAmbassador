## Working with Firmata (v2.5) in Lua

### Status

Working prototype


### Requirements
```
OS: Linux
Language: Lua 5.3
```

### Core functions implemented

- [x] Get ambassador interface: `local Firmata = request('Firmata.Ambassador.Interface')`
- [x] Digital pin read: `Firmata:DigitalRead(PinNumber)`
- [x] Digital pin write: `Firmata:DigitalWrite({ Pin = int, Value = bool })`
- [x] Analog pin read: `Firmata:AnalogRead(PinNumber)`
- [x] Analog (PWM) pin write: `Firmata:AnalogWrite({ Pin = int, Value = (float in [0.0, 1.0)) })`
- [x] I2C read: `Firmata:I2cRead({ DeviceId = byte, Offset = byte, NumBytes = byte })`
- [x] I2C write: `Firmata:I2cWrite({ DeviceId = byte, Offset = byte, Data = { byte, ... } })`

### First launch

  * Clone
  * Connect Arduino
    * Flash Arduino with StandardFirmata
  * Run `$ ./CLI_SmokeTest.lua`
    * If it fails, change there `local PortName = '/dev/ttyUSB0'` to your port name.
      * If it still fails, create an issue.

### Notes

* For simple demo look to [CLI_SmokeTest.lua](https://github.com/martin-eden/FirmataAmbassador/blob/main/CLI_SmokeTest.lua).

* As a sediments, there are set of command-line tools to work with date/time from real-time clock module on DS3231. But I'll throw them later.

### See also
  * [My other repositories.](https://github.com/martin-eden/contents)

2023-06-13

2024-01-03
