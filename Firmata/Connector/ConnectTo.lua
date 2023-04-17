--[[
  Open TTY port for Firmata usage.

  Baud 57600. After opening port, delay is required to give Firmata
  time to initialize.
]]

local GetPortParams = request('!.mechs.tty.get_port_params')
local PortSetNonBlockingRead = request('!.mechs.tty.set_non_blocking_read')
local SleepSec = request('!.system.sleep')

local SysGetByte = request('!.file.get_byte')
local SysPutByte = request('!.file.put_byte')

return
  function(self, PortName)
    if self.IsConnected then
      self:Disconnect()
    end

    assert_string(PortName)

    self.OriginalPortParams = GetPortParams(PortName)

    local Baud = 57600
    local ReadTimeoutSec = 0.5

    PortSetNonBlockingRead(PortName, ReadTimeoutSec, Baud)

    self.InputStream = io.open(PortName, 'rb')

    self.OutputStream = io.open(PortName, 'wb')
    self.OutputStream:setvbuf('no')

    local WarmupDelaySec = 3.5 -- down to 3.17s possible

    SleepSec(WarmupDelaySec)

    self.PortName = PortName

    self.IsConnected = true

    -- Instantiate GetByte()/PutByte() using upvalue to access file handles.
    self.GetByte =
      function()
        local Result = SysGetByte(self.InputStream)
        return Result
      end

    self.PutByte =
      function(Byte)
        SysPutByte(self.OutputStream, Byte)
      end

    return self.IsConnected
  end
