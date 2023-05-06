local DecodeByte = request('Handy.DecodeByte')
local DecodeBytes = request('Handy.DecodeBytes')

return
  function(Command, Data)
    return
      {
        Type = 'I2C response',
        DeviceId = DecodeByte(Data, 1),
        Offset = DecodeByte(Data, 3),
        Data = DecodeBytes(Data, 5),
      }
  end
