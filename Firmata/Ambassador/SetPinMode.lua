local CompileSetPinModeRequest = request('^.Compiler.MessageCompilers.Interface').SetPinMode

return
  function(self, Request)
    local Command = CompileSetPinModeRequest(Request)

    self:Send(Command)
  end
