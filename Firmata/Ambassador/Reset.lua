--[[
  Reset Firmata to initial state.
]]

local CompileResetRequest = request('^.Compiler.MessageCompilers.Interface').Reset

return
  function(self)
    local Command = CompileResetRequest()

    self:Send(Command)
  end
