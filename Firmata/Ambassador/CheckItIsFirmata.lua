return
  function(self)
    local Request = self:Compile({Type = 'get version'})
    self:Send(Request)

    local Response = self:Receive()

    if is_table(Response) and Response.Type and (Response.Type == 'Version') then
      return Response
    end
  end
