--[[
  Convert

    { ..., { Mode = 0, Resolution = 1 }, ... }

  to

    { ..., ['Digital input'] = true, ... }
]]

local GetPinModeName = request('GetPinModeName')

return
  function(PinRec)
    local Result = {}

    for ModeRecIdx, ModeRec in ipairs(PinRec) do
      local ModeName = GetPinModeName(ModeRec.Mode)

      if is_nil(ModeName) then
        -- Unknown mode.
        Complain(
          ('Failed to get pin mode name for mode rec #%d: mode %d.'):
          format(ModeRecIdx, ModeRec.Mode)
        )
        return
      end

      Result[ModeName] = true
    end

    return Result
  end
