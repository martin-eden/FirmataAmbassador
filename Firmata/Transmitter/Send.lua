--[[
  Convert message to bytes and write to stream.

  Message
  ~~~~~~~
    IsSysex - Bool
    Command - Byte
    Data - array of Byte
]]

local assert_byte = request('!.number.assert_byte')
local Signatures = request('^.Markers')

local SysexStart = Signatures.SysexStart
local SysexEnd = Signatures.SysexEnd

return
  function(self, Message)
    assert_table(Message)
    assert_byte(Message.Command)
    assert_table(Message.Data)
    assert_boolean(Message.IsSysex)

    assert(is_function(self.PutByte), 'No function for PutByte().')

    local PutByte = self.PutByte

    if Message.IsSysex then
      PutByte(SysexStart)
    end

    PutByte(Message.Command)
    for i = 1, #Message.Data do
      PutByte(Message.Data[i])
    end

    if Message.IsSysex then
      PutByte(SysexEnd)
    end
  end
