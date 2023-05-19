return
  function(self)
    self:CompileAndSend('I2cInit')

    self.IsI2cInitialized = true
  end
