--[[
  Convert pin modes description from Firmata to more useful format.

  Input

    {
      { <Pin modes description from Firmata> },
      ...
    }

  Output

    {
      { [ DIO = true, ] [ AI = true, ] [ PWM = true, ] [ I2C = true, ] },
      ...
    }

  Output modes

    DIO - (d)igital (i)nput-(o)utput. Includes modes (digital input,
      digital input-pullup, digital output, servo).
    AI - (a)nalog (i)input
    PWM - (p)ulse-(w)idth (m)odulation
    I2C - ({i})nter-({i})ntegrated (c)ircuit

  Note

    In Firmata format each pin mode is described by .Mode and .Resolution.
    For further work .Resolution is not used. So this field is dropped.
]]

local NamePinModes = request('NamePinModes')
local FigureOutPinRoles = request('FigureOutPinRoles')

return
  function(FirmataPinsModes)
    local Result = {}

    for PinRecIdx, PinRec in ipairs(FirmataPinsModes) do
      local NamedPinModes = NamePinModes(PinRec)
      if is_nil(NamedPinModes) then
        Complain(('Failed at naming modes for pin record #%d.'):format(PinRecIdx))
        return
      end

      local PinRoles = FigureOutPinRoles(NamedPinModes)
      if is_nil(PinRoles) then
        Complain(('Failed at shortening pin modes description for pin record #%d.'):format(PinRecIdx))
        return
      end

      table.insert(Result, PinRoles)
    end

    return Result
  end
