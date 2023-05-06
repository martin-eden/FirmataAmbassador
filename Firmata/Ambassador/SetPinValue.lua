local CompileSetPinValueRequest = request('^.Compiler.MessageCompilers.Interface').SetPinValue

return
  function(self, Request)
    local Command = CompileSetPinValueRequest(Request)

    self:Send(Command)
  end
