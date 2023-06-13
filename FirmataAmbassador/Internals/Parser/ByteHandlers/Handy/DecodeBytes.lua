--[[
  Decode to array of bytes.

  Input

    <Message> - array of Byte
    <StartIdx> - Byte - start position

  Output

    array of Byte
]]

local DecodeByte = request('DecodeByte')

return
  function(Message, StartIdx)
    local Result = {}

    local i = StartIdx
    while (i + 1 <= #Message) do
      local Byte = DecodeByte(Message, i)

      table.insert(Result, Byte)

      i = i + 2
    end

    return Result
  end
