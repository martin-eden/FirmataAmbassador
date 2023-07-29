local GetPinModes = request('GetPinModes')

return
  function(RawPinsModes)
    local Result = {}

    for _, RawPinModes in ipairs(RawPinsModes) do
      local PinModes = GetPinModes(RawPinModes)

      table.insert(Result, PinModes)
    end

    return Result
  end
