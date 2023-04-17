local DecodeString = request('Handy.DecodeString')

return
  function(Message)
    return
      {
        Type = 'Version and name report',
        Major = Message[1],
        Minor = Message[2],
        FirmwareName = DecodeString(Message, 3),
      }
  end
