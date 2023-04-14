local SleepSec = request('!.system.sleep')

return
  function(self, aPortName)
    if (self.IsConnected) then
      print('Already connected.')
      return
    end

    assert_string(aPortName)
    self.PortName = aPortName
    self:OpenPort()

    local WarmupDelaySec = 3.5
    print(('Warmup delay for %.1f seconds.'):format(WarmupDelaySec))
    SleepSec(WarmupDelaySec)

    self.IsConnected = true

    print('Connected.')
  end
