--[[
  Close opened TTY port and restore it's original configuration.
]]

local SetPortParams = request('!.mechs.tty.set_port_params')

return
  function(self)
    if not self.IsConnected then
      return
    end

    self.InputStream:close()
    self.InputStream = nil

    self.OutputStream:close()
    self.OutputStream = nil

    SetPortParams(self.PortName, self.OriginalPortParams)

    self.PortName = nil
    self.OriginalPortParams = nil

    self.GetByte = nil
    self.PutByte = nil

    self.IsConnected = false
  end
