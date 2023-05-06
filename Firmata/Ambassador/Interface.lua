return
  {
    -- Error output. Feel free to redefine.
    Complain = function(self, Msg) print(Msg) end,

    -- High-level methods:
    GetFirmataUsbPorts = request('GetFirmataUsbPorts'),
    GetOpenedI2cPorts = request('GetOpenedI2cPorts'),

    -- Connection management:
    ConnectTo = request('ConnectTo'),
    Disconnect = request('Disconnect'),
    IsConnected = function(self) return self.Connector.IsConnected end,
    GetPortName = function(self) return self.Connector.PortName end,

    -- Main functions:
    I2cRead = request('I2cRead'),
    I2cWrite = request('I2cWrite'),
    DigitalRead = request('DigitalRead'),
    DigitalWrite = request('DigitalWrite'),
    AnalogRead = request('AnalogRead'),
    AnalogWrite = request('AnalogWrite'),

    GetVersion = request('GetVersion'),
    GetVersionAndName = request('GetVersionAndName'),

    -- Implementation internals:
    Connector = request('^.Connector.Interface'),
    Transmitter = request('^.Transmitter.Interface'),
    Parser = request('^.Parser.Interface'),
    SetPinMode = request('SetPinMode'),
    SetPinValue = request('SetPinValue'),
    Send = request('Send'),
    Receive = request('Receive'),
    EatGreetings = request('EatGreetings'),
    Reset = request('Reset'),
    I2cInit = request('I2cInit'),
    IsI2cInitialized = false,
  }
