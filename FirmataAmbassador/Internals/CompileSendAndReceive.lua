--[[
  Compile command, send it and return respose.
]]

return
  function(self, CompilerName, Request)
    self:CompileAndSend(CompilerName, Request)
    return self:Receive()
  end
