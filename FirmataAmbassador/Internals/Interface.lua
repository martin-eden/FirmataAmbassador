--[[
  Implementation internals for FirmataAmbassador library.

  As with any internals they are subject to frequent breaking changes.
]]

return
  {
    Connector = request('Connector.Interface'),
    Transmitter = request('Transmitter.Interface'),
    Parser = request('Parser.Interface'),

    -- Awareness and exploration:
    AvailablePinsRoles = nil,
    AvailablePinsModes = nil,

    SetPinMode = request('SetPinMode'),
    SetPinValue = request('SetPinValue'),
    Send = request('Send'),
    CompileAndSend = request('CompileAndSend'),
    Receive = request('Receive'),
    CompileSendAndReceive = request('CompileSendAndReceive'),
    GotInitGreetings = request('GotInitGreetings'),

    Reset = request('Reset'),
    GetBoardConfiguration = request('GetBoardConfiguration'),
    GetVersion = request('GetVersion'),
    GetVersionAndName = request('GetVersionAndName'),

    I2cInit = request('I2cInit'),
    IsI2cInitialized = false,
  }
