local CompileCommand = request('Handy.CompileCommand')
local IsVersionResponse = request('Handy.IsVersionResponse')

return
  function(self)
    local Result

    local Command = CompileCommand({Type = 'Get version'})
    self:Send(Command)

    local Response = self:Receive()

    if IsVersionResponse(Response) then
      Result = Response
    end

    return Result
  end
