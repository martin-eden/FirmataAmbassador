local DecodeString = request('Handy.DecodeString')

return
  function(Command, Data)
    return
      {
        Type = 'Version and name report',
        Major = Data[1],
        Minor = Data[2],
        FirmwareName = DecodeString(Data, 3),
      }
  end
