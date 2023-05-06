-- local t2s = request('!.table.as_string')

return
  function(self)
    if not self:IsConnected() then
      self:Complain('Cannot receive, not connected.')
      return
    end

    local Transmitter = self.Transmitter
    local RawMessage = Transmitter:Receive()

    if is_nil(RawMessage) then
      self:Complain('Failed to receive message from Firmata.')
      return
    end

    -- print(('Raw message: "%s".'):format(t2s(RawMessage)))

    local Result

    local Parser = self.Parser

    Result = Parser:Parse(RawMessage)

    if (is_nil(Result)) then
      self:Complain('Failed to parse message.')
      return
    else
      -- print(('Parsed message: "%s".'):format(t2s(Result)))
    end

    return Result
  end
