-- Error output. Feel free to redefine.
-- For sure definition of global function will be removed from here.

_G.Complain = function(Msg) print(Msg) end

return
  {
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

    -- Implementation internals:
    Connector = request('Internals.Connector.Interface'),
    Transmitter = request('Internals.Transmitter.Interface'),
    Parser = request('Internals.Parser.Interface'),

    SetPinMode = request('Internals.SetPinMode'),
    SetPinValue = request('Internals.SetPinValue'),
    Send = request('Internals.Send'),
    CompileAndSend = request('Internals.CompileAndSend'),
    Receive = request('Internals.Receive'),
    CompileSendAndReceive = request('Internals.CompileSendAndReceive'),
    GotInitGreetings = request('Internals.GotInitGreetings'),

    Reset = request('Internals.Reset'),
    GetBoardConfiguration = request('Internals.GetBoardConfiguration'),
    GetVersion = request('Internals.GetVersion'),
    GetVersionAndName = request('Internals.GetVersionAndName'),

    I2cInit = request('Internals.I2cInit'),
    IsI2cInitialized = false,
  }
