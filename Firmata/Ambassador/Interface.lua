return
  {
    -- High-level methods:
    GetFirmataUsbPorts = request('GetFirmataUsbPorts'),
    GetOpenedI2cPorts = request('GetOpenedI2cPorts'),

    -- Connection management:
    ConnectTo = request('ConnectTo'),
    Disconnect = request('Disconnect'),
    IsConnected = function(self) return self.Connector.IsConnected end,
    GetPortName = function(self) return self.Connector.PortName end,

    -- Main functions:
    GetVersion = request('GetVersion'),
    GetVersionAndName = request('GetVersionAndName'),
    I2cRead = request('I2cRead'),
    I2cWrite = request('I2cWrite'),

    -- Implementation internals:
    Connector = request('^.Connector.Interface'),
    Transmitter = request('^.Transmitter.Interface'),
    Parser = request('^.Parser.Interface'),
    --
    Send = request('Send'),
    Receive = request('Receive'),
    CheckItIsFirmata = request('CheckItIsFirmata'),
    InitializeI2c = request('InitializeI2c'),
    IsI2cInitialized = false,
    --
  }
