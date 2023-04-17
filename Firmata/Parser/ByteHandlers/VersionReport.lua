return
  function(Message)
    return
      {
        Type = 'Version report',
        Major = Message[1],
        Minor = Message[2],
      }
  end
