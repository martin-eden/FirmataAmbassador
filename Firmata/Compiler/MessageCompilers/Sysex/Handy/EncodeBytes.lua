local EncodeByte = request('EncodeByte')

return
  function(Data)
    assert_table(Data)

    local Result

    Result = {}
    for i, Byte in ipairs(Data) do
      table.insert(Result, EncodeByte(Byte))
    end

    return Result
  end
