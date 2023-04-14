local SetPortParams = request('!.mechs.tty.set_port_params')

return
  function(self)
    assert_string(self.PortName)

    self.InputStream:close()
    self.InputStream = nil

    self.OutputStream:close()
    self.OutputStream = nil

    SetPortParams(self.PortName, self.OriginalPortParams)
  end
