return
  function(self, Data)
    assert_string(Data)

    self.Connector.OutputStream:write(Data)
  end
