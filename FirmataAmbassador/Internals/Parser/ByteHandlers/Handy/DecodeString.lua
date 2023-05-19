--[[
  Data bytes in Firmata carry 7 bits of data.
  Data bytes in strings carry 8 bits of data.
  So each byte of string is exploded to two data bytes of Firmata.

  This function implodes Firmata 7-bit bytes to 8-bit bytes and
  converts them to string.
]]

local DecodeBytes = request('DecodeBytes')

return
  function(Message, StartIdx)
    local Result

    local Bytes = DecodeBytes(Message, StartIdx)
    Result = string.char(table.unpack(Bytes))

    return Result
  end
