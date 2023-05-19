--[[
  Request available modes for every pin.
]]

local GetPinsModesCmd = request('^.Markers').PinsModesRq

return
  function()
    return
      {
        Command = GetPinsModesCmd,
        Data = {},
      }
  end
