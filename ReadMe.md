## Working with Firmata (v2.5) in Lua

### Status

Working prototype


### Requirements
```
OS: Linux
Language: Lua 5.3
```

### Core functions implemented

- [x] Get object: `local Firmata = request('Firmata.Ambassador.Interface')`
- [x] Digital pin 3 read: `Firmata:DigitalRead(3)`
- [x] Digital pin write: `Firmata:DigitalWrite({ Pin = 13, Value = true })`
- [x] Analog pin A0 read: `Firmata:AnalogRead(0)`
- [x] Analog (PWM) pin write: `Firmata:AnalogWrite({ Pin = 3, Value = 1 / 256 })`
- [x] I2C device read: `Firmata:I2cRead({ DeviceId = 0x68, Offset = 0x00, NumBytes = 0x13 })`
- [x] I2C device write: `Firmata:I2cWrite({ DeviceId = 0x68, Offset = 0x00, Data = { 0x02, 0x52, 0x16 } })`

### First launch

  * Clone
  * Connect Arduino
    * Flash Arduino with StandardFirmata
  * Run `$ ./CLI_SmokeTest.lua`
    * If it fails, change there `local PortName = '/dev/ttyUSB0'` to your port name.
      * If it still fails, create an issue.

### Notes

* For simple demo look to [CLI_SmokeTest.lua](https://github.com/martin-eden/FirmataAmbassador/blob/main/CLI_SmokeTest.lua).

* As a sediments, there are set of command-line tools to
get/parse/compile/set time from real-time clock module on DS3231.
But I'll throw them later.

### See also
  * [My other repositories.](https://github.com/martin-eden/contents)

2023-06-13
