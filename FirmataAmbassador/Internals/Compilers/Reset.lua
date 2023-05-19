--[[
  Reset Firmata.
]]

local CmdReset = request('^.Markers').Reset

return
  function()
    return
      {
        Command = CmdReset,
        Data = {},
      }
  end
