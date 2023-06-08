local DescribePins = request('GetBoardConfiguration.DescribePins')

return
  function(self)
    self:CompileAndSend('GetPinsModes')

    local Response = self:Receive()
    if not is_table(Response) then
      Complain("GetBoardConfiguration: didn't get response.")
      return
    end

    local PinsDescription = DescribePins(Response.Data)

    local Result =
      {
        Type = 'Board configuration',
        Pins = PinsDescription,
      }

    return Result
  end
