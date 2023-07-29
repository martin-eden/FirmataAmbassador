--[[
  Get board pin capabilities and current pin state.

  Input

    none

  Output

    {
      Pins
      {
        Index - Byte - zero-based index for pin operations
        SupportedModes -
        {
          ...
          List of available modes for current pin. Indexed by mode name.

          Excerpt:

            ['Digital input-pullup'] = True
            ['Digital input'] = True

        }
        CurrentMode - String - Current pin mode name.
        Value - Byte - Usually contains last value written to pin.
          But the exact meaning depends of pin mode.
      },
      ...
    }
]]

local GetPinsModes = request('GetBoardConfiguration.GetPinsModes')
local GetPinModeName = request('GetBoardConfiguration.GetPinModeName')

return
  function(self)
    local Result =
      {
        Type = 'Pins roles and their states.',
        Pins = {},
      }

    -- Get a number of pins and roles of each pin.
    local AvailablePinsModes
    do
      local Response = self:CompileSendAndReceive('GetPinsModes')

      if not is_table(Response) then
        Complain("GetBoardConfiguration: didn't get response.")
        return
      end

      AvailablePinsModes = GetPinsModes(Response.Data)
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
      assert_integer(Response.PinIndex)
      assert_integer(Response.ModeIndex)
      assert_integer(Response.PinValue)

      assert(Response.PinIndex == PinIndex)

      local PinDescription =
        {
          Index = PinIndex,
          CurrentMode = GetPinModeName(Response.ModeIndex),
          Value = Response.PinValue,
          SupportedModes = AvailablePinsModes[PinNumber],
        }

      -- Modify <Result.Pins>.
      table.insert(Result.Pins, PinDescription)
    end

    -- [!] Setting object field.
    self.AvailablePinsModes = AvailablePinsModes

    return Result
  end
