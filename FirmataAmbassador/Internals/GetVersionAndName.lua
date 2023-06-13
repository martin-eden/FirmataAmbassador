local IsVersionAndNameResponse = request('Handy.IsVersionAndNameResponse')

return
  function(self)
    local Result

    local Response = self:CompileSendAndReceive('VersionAndName')

    if IsVersionAndNameResponse(Response) then
      Result = Response
    end

    return Result
  end
