--[[
  Get board pin capabilities and current pin state.

  Input

    none

  Output

    {
      Pins
      {
        PinIndex - Byte - zero-based index
        SupportedRoles -
        {
          ?[<String>] = true
          ...
        }
        CurrentModeName - String
        CurrentState - Byte
      },
      ...
    }
]]

local DescribePins = request('GetBoardConfiguration.DescribePins')

return
  function(self)
    self:CompileAndSend('GetPinsModes')
    local Response = self:Receive()

    if not is_table(Response) then
      Complain("GetBoardConfiguration: didn't get response.")
      return
    end

    local Result =
      {
        Type = 'Board configuration',
        Pins = {},
      }

    -- Get number of pins and capabilities for each pin.
    local PinsRolesAvailable = DescribePins(Response.Data)

    -- Get current mode for each pin.
    -- Modify <Result.Pins>.
    for i = 1, #PinsRolesAvailable do
      local PinIndex = i - 1

      self:CompileAndSend('GetPinState', { Pin = PinIndex })
      local Response = self:Receive()

      assert_table(Response)
      assert_string(Response.ModeName)
      assert_integer(Response.State)

      assert(Response.PinIndex == PinIndex)

      local PinDescription =
        {
          PinIndex = PinIndex,
          CurrentModeName = Response.ModeName,
          CurrentState = Response.State,
          SupportedRoles = PinsRolesAvailable[i],
        }

      table.insert(Result.Pins, PinDescription)
    end

    return Result
  end
