## Working with Firmata (v2.5) in Lua

### Status

Working prototype


### Requirements
```
OS: Linux
Language: Lua 5.3
```

### Core functions implemented

  * DigitalRead()
  * DigitalWrite()
  * AnalogRead()
  * AnalogWrite() (PWM of course)
  * I2cRead()
  * I2cWrite()

### Notes

* To understand how to use, start reading from [CLI_SmokeTest.lua](https://github.com/martin-eden/FirmataAmbassador/blob/main/CLI_SmokeTest.lua).

* As a sediments, there are set of command-line tools to
get/parse/compile/set time from real-time clock module on DS3231.
But I'll throw them later.

### See also
  * [My other repositories.](https://github.com/martin-eden/contents)

2023-05-14
