return
  {
    Connect = request('Connect'),
    Disconnect = request('Disconnect'),
    GetVersion = request('GetVersion'),
    -- GetVersionAndFirmware = request('GetVersionAndFirmware'),
    -- ReadFromI2CDevice = request('ReadFromI2CDevice'),
    -- WriteToI2CDevice = request('WriteToI2CDevice'),
    --
    Connector = request('^.Connector.Interface'),
    CompileCommand = request('^.Compiler.CompileCommand'),
    Parse = request('^.Parser.ParseStream'),
    --
    Compile = request('Compile'),
    Send = request('Send'),
    Receive = request('Receive'),
    --
    CheckItIsFirmata = request('CheckItIsFirmata'),
  }
