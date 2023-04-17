return
  function(Message, RequiredType)
    assert_string(RequiredType)

    if not is_table(Message) then
      return false
    end

    return is_string(Message.Type) and (Message.Type == RequiredType)
  end
