--[[
  Close opened TTY port and restore it's original configuration.
]]

local SetPortParams = request('!.mechs.tty.set_port_params')

return
  function(self)
    assert_string(self.PortName)

    if self.IsConnected then
      self.GetByte = nil
      self.PutByte = nil

      self.InputStream:close()
      self.InputStream = nil

      self.OutputStream:close()
      self.OutputStream = nil

      SetPortParams(self.PortName, self.OriginalPortParams)

      self.PortName = nil
      self.OriginalPortParams = nil

      self.IsConnected = false
    end

    return not self.IsConnected
  end
