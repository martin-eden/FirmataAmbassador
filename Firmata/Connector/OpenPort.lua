local GetPortParams = request('!.mechs.tty.get_port_params')
local PortSetNonBlockingRead = request('!.mechs.tty.set_non_blocking_read')

return
  function(self)
    assert_string(self.PortName)

    self.OriginalPortParams = GetPortParams(self.PortName)

    local Baud = 57600
    local ReadTimeoutSec = 0.5

    PortSetNonBlockingRead(self.PortName, ReadTimeoutSec, Baud)

    self.InputStream = io.open(self.PortName, 'rb')

    self.OutputStream = io.open(self.PortName, 'wb')
    self.OutputStream:setvbuf('no')

    print(('Opened port %s.'):format(self.PortName))
  end
