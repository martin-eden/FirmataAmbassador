local GetPinModeName = request('GetPinModeName')
local CompressNamedPinModeRec = request('CompressNamedPinModeRec')

local DescribePins =
  function(FirmataPinsModes)
    local Result = {}

    for PinNumber, PinRec in ipairs(FirmataPinsModes) do
      local CurrentPinModes = {}

      for _, ModeRec in ipairs(PinRec) do
        local ModeName = GetPinModeName(ModeRec.Mode)
        if not is_nil(ModeName) then
          CurrentPinModes[ModeName] = true
        end
      end

      CurrentPinModes = CompressNamedPinModeRec(CurrentPinModes)

      CurrentPinModes.PinIndex = PinNumber - 1

      table.insert(Result, CurrentPinModes)
    end

    return Result
  end

return DescribePins
