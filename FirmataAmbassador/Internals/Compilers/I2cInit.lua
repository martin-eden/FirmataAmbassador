--[[
  Init I2C pins.
]]

local I2cInitCmd = request('^.Markers').I2cInit

return
  function()
    return
      {
        Command = I2cInitCmd,
        Data = {},
      }
  end
