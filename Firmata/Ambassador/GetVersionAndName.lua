local CompileVersionAndNameRequest = request('^.Compiler.MessageCompilers.Interface').VersionAndName
local IsVersionAndNameResponse = request('Handy.IsVersionAndNameResponse')

return
  function(self)
    local Result

    local Command = CompileVersionAndNameRequest()

    self:Send(Command)

    local Response = self:Receive()

    if IsVersionAndNameResponse(Response) then
      Result = Response
    end

    return Result
  end
