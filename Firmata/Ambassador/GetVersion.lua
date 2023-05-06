local CompileVersionRequest = request('^.Compiler.MessageCompilers.Interface').Version
local IsVersionResponse = request('Handy.IsVersionResponse')

return
  function(self)
    local Result

    local Command = CompileVersionRequest()

    self:Send(Command)

    local Response = self:Receive()

    if IsVersionResponse(Response) then
      Result = Response
    end

    return Result
  end
