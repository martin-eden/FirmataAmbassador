local t2s = request('!.table.as_string')

return
  function(self)
    local Result

    if not self:IsConnected() then
      print('Cannot receive, not connected.')
      return
    end

    local Transmitter = self.Transmitter
    local RawMessage = Transmitter:Receive()

    if is_nil(RawMessage) then
      print('Failed to receive message from Firmata.')
      return
    end

    -- print(('Raw message: "%s".'):format(t2s(RawMessage)))

    local Parser = self.Parser
    Result = Parser:Parse(RawMessage)

    if (is_nil(Result)) then
      -- print(('Can\'t parse "%s".'):format(t2s(RawMessage)))

      Result = RawMessage
      Result.Type = 'Unparsed message.'
    else
      -- print(('Parsed to: "%s".'):format(t2s(Result)))
    end

    return Result
  end
