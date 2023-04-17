return
  {
    -- Main functionality.
    ConnectTo = request('ConnectTo'),
    Disconnect = request('Disconnect'),

    --[[
      Exported functions for operations on stream.
      Actual values are set after successful connection.
    --]]
    GetByte = nil,
    PutByte = nil,

    --
    IsConnected = false,
    PortName = nil,
    InputStream = nil,
    OutputStream = nil,
    OriginalPortParams = '',
  }
