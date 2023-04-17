local DecodeByte = request('Handy.DecodeByte')
local DecodeBytes = request('Handy.DecodeBytes')

return
  function(Message)
    return
      {
        Type = 'I2C response',
        DeviceId = DecodeByte(Message, 1),
        Offset = DecodeByte(Message, 3),
        Data = DecodeBytes(Message, 5),
      }
  end
