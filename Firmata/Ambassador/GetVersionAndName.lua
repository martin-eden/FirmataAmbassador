local CompileCommand = request('Handy.CompileCommand')
local IsVersionAndNameResponse = request('Handy.IsVersionAndNameResponse')

return
  function(self)
    local Result

    local Command = CompileCommand({Type = 'Get version and name'})
    self:Send(Command)

    local Response = self:Receive()

    if IsVersionAndNameResponse(Response) then
      Result = Response
    end

    return Result
  end
