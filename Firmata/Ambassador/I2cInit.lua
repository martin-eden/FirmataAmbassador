local CompileI2cInitRequest = request('^.Compiler.MessageCompilers.Interface').I2cInit

return
  function(self)
    local Command = CompileI2cInitRequest()

    self:Send(Command)

    self.IsI2cInitialized = true
  end
