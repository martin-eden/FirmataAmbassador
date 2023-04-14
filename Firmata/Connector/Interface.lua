return
  {
    Connect = request('Connect'),
    Disconnect = request('Disconnect'),
    --
    IsConnected = false,
    PortName = nil,
    InputStream = nil,
    OutputStream = nil,
    OriginalPortParams = '',
    --
    OpenPort = request('OpenPort'),
    ClosePort = request('ClosePort'),
  }
