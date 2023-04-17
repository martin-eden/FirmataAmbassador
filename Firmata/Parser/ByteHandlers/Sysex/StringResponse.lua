local DecodeString = request('Handy.DecodeString')

return
  function(Message)
    return
      {
        Type = 'String response',
        Data = DecodeString(Message, 1),
      }
  end
