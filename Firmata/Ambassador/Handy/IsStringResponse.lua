local CheckMessage = request('CheckMessage')

return
  function(Message)
    return CheckMessage(Message, 'String response')
  end
