local AnalogReportCommands = request('^.^.Markers').AnalogPinReport

local MinCommandId = AnalogReportCommands[0x0]
local MaxCommandId = AnalogReportCommands[0xF]

local DecodeWord = request('Handy.DecodeWord')

return
  function(Command, Data)
    assert((Command >= MinCommandId) and (Command <= MaxCommandId), 'Command out of supported range.')

    -- Map (0xE0..0xEF) to (0x00..0x0F).
    local AnalogPinNumber = Command - MinCommandId
    local PinValueWord = DecodeWord(Data)

    return
      {
        Type = 'Analog value report',
        Pin = AnalogPinNumber,
        Value = PinValueWord,
      }
  end
