local CheckMessageType = request('CheckMessageType')

return
  function(Message)
    if is_table(Message) then
      return CheckMessageType(Message, 'Version and name report')
    end
  end
