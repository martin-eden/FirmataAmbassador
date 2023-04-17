--[[
  Sysex message handlers.

  Same format as for main interface: table {[<signature-byte>] = <handler>}.
]]

return
  {
    [0x79] = request('VersionAndNameReport'),
    [0x71] = request('StringResponse'),
    [0x77] = request('I2cResponse'),
  }
