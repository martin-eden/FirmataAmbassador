--[[
  Each pin mode is described as record { Mode: byte, Resolution: byte }.
  Resulution is value resolution in bits. So 10 means value can be
  from 0 to 1023.

  We are not plan to use pin mode resolution in further work so just
  discarding it here.
]]

local DescribePins = request('GetBoardConfiguration.DescribePins')

return
  function(self)
    self:CompileAndSend('GetPinsModes')

    local Response = self:Receive()
    if not is_table(Response) then
      Complain("GetBoardConfiguration: didn't get response.")
      return
    end

    local Result =
      {
        Type = 'Board configuration',
        Pins = DescribePins(Response.Data),
      }

    return Result
  end
