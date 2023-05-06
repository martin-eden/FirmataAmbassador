local CheckMessageType = request('CheckMessageType')

return
  function(Message)
    if is_table(Message) then
      return CheckMessageType(Message, 'Version report')
    end
  end
