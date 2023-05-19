--[[
  Request firmware version.
]]

local VersionRequestCmd = request('^.Markers').Version

return
  function()
    return
      {
        Command = VersionRequestCmd,
        Data = {},
      }
  end
