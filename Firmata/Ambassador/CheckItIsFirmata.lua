--[[
  Check that there is Firmata firmaware on opened USB port.

  Firmata sends two messages after opening port: fixed-length
  version report and variable-length version report. So we
  will just listen for that two messages.

  This internal method must be called once after port is opened.
]]

local IsVersionResponse = request('Handy.IsVersionResponse')
local IsVersionAndNameResponse = request('Handy.IsVersionAndNameResponse')

return
  function(self)
    local Result = false

    local Msg1, Msg2

    Msg1 = self:Receive()

    if IsVersionResponse(Msg1) then
      Msg2 = self:Receive()
      if IsVersionAndNameResponse(Msg2) then
        Result = true
      end
    end

    return Result
  end
