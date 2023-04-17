local GenerateSysex = request('Handy.GenerateSysex')

local CmdInitI2c = 0x78

return
  function(self)
    local Command = GenerateSysex(CmdInitI2c)
    self:Send(Command)
    self.IsI2cInitialized = true
  end
