local IsVersionResponse = request('Handy.IsVersionResponse')

return
  function(self)
    local Result

    local Response = self:CompileSendAndReceive('Version')

    if IsVersionResponse(Response) then
      Result = Response
    end

    return Result
  end
