local CheckMessage = request('CheckMessage')

return
  function(Message)
    return CheckMessage(Message, 'Version report')
  end
