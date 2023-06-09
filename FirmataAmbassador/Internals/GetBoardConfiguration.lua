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
          ?[<String>] = Bool
          ...
        }
        SupportedModes -
        {
          ?[<String>] = True
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
    local Result =
      {
        Type = 'Pins roles and their states.',
        Pins = {},
      }

    -- Get number of pins and roles of each pin.
    local AvailablePinsModes
    do
      local Response = self:CompileSendAndReceive('GetPinsModes')

      if not is_table(Response) then
        Complain("GetBoardConfiguration: didn't get response.")
        return
      end

      AvailablePinsModes = DescribePins(Response.Data)
    end

    -- Get current mode for each pin.
    for PinNumber = 1, #AvailablePinsModes do
      local PinIndex = PinNumber - 1

      local Response = self:CompileSendAndReceive('GetPinState', { Pin = PinIndex })

      if not is_table(Response) then
        Complain(
          ("GetBoardConfiguration: didn't get state response for pin [%d]."):
          format(PinNumber)
        )
        return
      end

      assert_table(Response)
      assert_string(Response.ModeName)
      assert_integer(Response.State)

      assert(Response.PinIndex == PinIndex)

      local PinDescription =
        {
          PinIndex = PinIndex,
          CurrentModeName = Response.ModeName,
          CurrentState = Response.State,
          SupportedRoles = AvailablePinsModes[PinNumber],
        }

      -- Modify <Result.Pins>.
      table.insert(Result.Pins, PinDescription)
    end

    -- [!] Setting object field.
    self.AvailablePinsModes = AvailablePinsModes


    return Result
  end
