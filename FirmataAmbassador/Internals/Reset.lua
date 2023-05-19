--[[
  Reset Firmata to initial state.
]]

return
  function(self)
    self:CompileAndSend('Reset')
  end
