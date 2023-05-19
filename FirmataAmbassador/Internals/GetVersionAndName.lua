local IsVersionAndNameResponse = request('Handy.IsVersionAndNameResponse')

return
  function(self)
    local Result

    self:CompileAndSend('VersionAndName')

    local Response = self:Receive()

    if IsVersionAndNameResponse(Response) then
      Result = Response
    end

    return Result
  end
