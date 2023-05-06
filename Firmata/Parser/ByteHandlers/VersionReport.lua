return
  function(Command, Data)
    return
      {
        Type = 'Version report',
        Major = Data[1],
        Minor = Data[2],
      }
  end
