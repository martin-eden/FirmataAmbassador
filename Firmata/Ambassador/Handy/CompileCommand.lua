local Markers = request('^.^.Markers')
local GenSysex = request('GenerateSysex')
local t2s = request('!.table.as_string')

return
  function(Command)
    assert_table(Command)
    assert_string(Command.Type)

    local Result
    if (Command.Type == 'Get version') then
      Result = { Command = Markers.FirmwareVersion }
    elseif (Command.Type == 'Get version and name') then
      Result = GenSysex(Markers.Sysex.FirmwareNameAndVersion)
    end

    assert_table(Result)
    -- print(('Compiled "%s" to "%s".'):format(t2s(Command), t2s(Result)))

    return Result
  end
