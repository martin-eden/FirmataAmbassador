return
  {
    Connect = request('Connect'),
    Disconnect = request('Disconnect'),
    --
    InputStream = nil,
    OutputStream = nil,
    PortName = '',
    OpenPort = request('OpenPort'),
    CheckItIsFirmata = request('CheckItIsFirmata'),
    --
    IsConnected = false,
    OriginalPortParams = '',
  }
