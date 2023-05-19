--[[
  Request version and firmware name.
]]

local VersionAndNameRequestCmd = request('^.Markers').VersionAndName

return
  function()
    return
      {
        Command = VersionAndNameRequestCmd,
        Data = {},
      }
  end
