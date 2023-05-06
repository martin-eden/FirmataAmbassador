--[[
  Init I2C pins.
]]

local CmdI2cInit = request('^.^.^.Markers').Sysex.I2cInit

return
  function()
    return
      {
        IsSysex = true,
        Command = CmdI2cInit,
        Data = {},
      }
  end
