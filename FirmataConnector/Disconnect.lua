local SetPortParams = request('!.mechs.tty.set_port_params')

return
  function(self)
    if (self.IsConnected) then
      self.InputStream:close()
      self.InputStream = nil

      self.OutputStream:close()
      self.OutputStream = nil

      SetPortParams(self.PortName, self.OriginalPortParams)

      self.IsConnected = false

      print('Disconnected.')
    else
      print('Not connected.')
    end
  end
