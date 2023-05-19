--[[
  Open/close port with Firmata device.

  Port is usually file name like "/dev/ttyUSB0".

  When connected, sets .GetByte() and .PutByte().
]]

return
  {
    -- Main functionality.
    ConnectTo = request('ConnectTo'),
    Disconnect = request('Disconnect'),

    -- Exports.
    GetByte = nil,
    PutByte = nil,

    -- Internals.
    IsConnected = false,
    PortName = nil,
    InputStream = nil,
    OutputStream = nil,
    OriginalPortParams = nil,
    SpawnGetByte = request('SpawnGetByte'),
    SpawnPutByte = request('SpawnPutByte'),
  }
