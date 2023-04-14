local SetPortParams = request('!.mechs.tty.set_port_params')

return
  function(self)
    if (not self.IsConnected) then
      print('Not connected.')
      return
    end

    self:ClosePort()
    self.PortName = nil

    self.IsConnected = false

    print('Disconnected.')
  end
