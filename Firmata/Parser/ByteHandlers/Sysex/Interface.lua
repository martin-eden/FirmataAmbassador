--[[
  Sysex message handlers.

  Same format as for main interface: table {[<signature-byte>] = <handler>}.
]]

local Signatures = request('^.^.^.Markers').Sysex

return
  {
    [Signatures.VersionAndName] = request('VersionAndNameReport'),
    [Signatures.String] = request('StringResponse'),
    [Signatures.I2cData] = request('I2cResponse'),
  }
