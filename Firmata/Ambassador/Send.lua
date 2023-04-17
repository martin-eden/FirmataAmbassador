local GetHexDump = request('!.string.get_hex_dump')

return
  function(self, Data)
    if not self:IsConnected() then
      -- print('Cannot send, not connected.')
      return
    end

    local Transmitter = self.Transmitter

    return Transmitter:Send(Data)
  end
