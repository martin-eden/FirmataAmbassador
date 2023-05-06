local DecodeString = request('Handy.DecodeString')

return
  function(Command, Data)
    return
      {
        Type = 'String response',
        Data = DecodeString(Data, 1),
      }
  end
