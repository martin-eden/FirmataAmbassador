--[[
  Request version and firmware name.
]]

local VersionAndNameRequest = request('^.^.^.Markers').Sysex.VersionAndName

return
  function()
    return
      {
        IsSysex = true,
        Command = VersionAndNameRequest,
        Data = {},
      }
  end
