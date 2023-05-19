local DigitalReportCommands = request('^.^.Markers').DigitalPortReport

local MinCommandId = DigitalReportCommands[0x0]
local MaxCommandId = DigitalReportCommands[0xF]

local DecodeByte = request('Handy.DecodeByte')

return
  function(Command, Data)
    assert((Command >= MinCommandId) and (Command <= MaxCommandId), 'Command out of supported range.')

    -- Map (0x90..0x9F) to (0x00..0x0F).
    local DigitalPortNumber = Command - MinCommandId
    local PortValueByte = DecodeByte(Data, 1)

    return
      {
        Type = 'Port value report',
        Port = DigitalPortNumber,
        Value = PortValueByte,
      }
  end
