--[[
  Interface is a table with following structure:

    Handlers
    ~~~~~~~~
    {
      [<Command>] = <Handler>(<Message>) -> Table
      ~~~~~~~~~~              ~~~~~~~~~
         Byte               array of Byte
    }

  How to use

    [Transmitter.Receive()] will provide you result in format
    { Command: Byte, Data: array of Byte }.

    If there is handler at [<Command>], call it with <Data>.
    Table with parsed message will be returned as result.
    Else just skip this message as we can't parse it.
]]

local Signatures = request('^.^.Markers')

local AnalogPinReportHandler = request('AnalogPinReport')
local DigitalPortReportHandler = request('DigitalPortReport')

return
  {
    [Signatures.String] = request('StringResponse'),

    [Signatures.PinsModesRy] = request('PinsModesResponse'),
    [Signatures.PinStateRy] = request('PinStateResponse'),

    [Signatures.I2cData] = request('I2cResponse'),

    [Signatures.DigitalPortReport[0x0]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0x1]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0x2]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0x3]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0x4]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0x5]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0x6]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0x7]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0x8]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0x9]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0xA]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0xB]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0xC]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0xD]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0xE]] = DigitalPortReportHandler,
    [Signatures.DigitalPortReport[0xF]] = DigitalPortReportHandler,

    [Signatures.AnalogPinReport[0x0]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0x1]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0x2]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0x3]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0x4]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0x5]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0x6]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0x7]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0x8]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0x9]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0xA]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0xB]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0xC]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0xD]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0xE]] = AnalogPinReportHandler,
    [Signatures.AnalogPinReport[0xF]] = AnalogPinReportHandler,

    [Signatures.Version] = request('VersionReport'),
    [Signatures.VersionAndName] = request('VersionAndNameReport'),
  }
