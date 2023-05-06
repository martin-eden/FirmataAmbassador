return
  function(Message, RequiredType)
    assert_table(Message)
    assert_string(Message.Type)
    assert_string(RequiredType)

    return (Message.Type == RequiredType)
  end
