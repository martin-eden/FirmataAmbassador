return
  function(self)
    local Request = self:CompileMessage({Type = 'get version'})
    self:SendMessage(Request)
    local Response = self:GetMessage()
    if is_table(Response) and (Response.Type == 'version') then
      return Response
    end
  end
