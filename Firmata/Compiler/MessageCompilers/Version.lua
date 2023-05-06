--[[
  Request firmware version.
]]

local VersionRequest = request('^.^.Markers').Version

return
  function()
    return
      {
        IsSysex = false,
        Command = VersionRequest,
        Data = {},
      }
  end
