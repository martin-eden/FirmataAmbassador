local IsVersionResponse = request('Handy.IsVersionResponse')

return
  function(self)
    local Result

    self:CompileAndSend('Version')

    local Response = self:Receive()

    if IsVersionResponse(Response) then
      Result = Response
    end

    return Result
  end
