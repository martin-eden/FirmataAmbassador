local Markers = request('^.Markers')
local Sysex = request('GenerateSysex')
local Quote = request('!.string.quote')
local GetHexDump = request('!.string.get_hex_dump')
local t2s = request('!.table.as_string')

return
  function(Command)
    assert_table(Command)
    assert_string(Command.Type)

    local Result
    if (Command.Type == 'get version') then
      Result = string.char(Markers.FirmwareVersion)
    end

    assert_string(Result)
    print('Compiled', t2s(Command), ('| %s | %s |'):format(Quote(Result), GetHexDump(Result)))

    return Result
  end
