--[[
  Convert firmata-specific description of mode to a more handy format.

  Example

    ( { ..., { Mode = 0, Resolution = 1 }, ... } )@

    ==

    { ..., ['Digital input'] = true, ... }
]]

local GetPinModeName = request('GetPinModeName')

return
  function(RawPinModes)
    local Result = {}

    for _, ModesRec in ipairs(RawPinModes) do
      local ModeName = GetPinModeName(ModesRec.Mode)

      assert_string(ModeName)

      Result[ModeName] = true
    end

    return Result
  end
