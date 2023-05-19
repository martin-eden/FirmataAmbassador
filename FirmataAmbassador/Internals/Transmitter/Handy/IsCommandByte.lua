--[[
  Determine whether byte type is command or not.

  Input: Byte
  Output: Bool
]]

local assert_byte = request('!.number.assert_byte')
local GetBit = request('!.number.get_bit')
local CmdSysexEnd = request('^.^.Markers')

return
  function(CommandByte)
    assert_byte(CommandByte)

    local Result

    Result = GetBit(CommandByte, 7) and (CommandByte ~= CmdSysexEnd)

    return Result
  end
