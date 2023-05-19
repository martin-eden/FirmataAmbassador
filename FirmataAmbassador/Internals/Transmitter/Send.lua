--[[
  Convert message to bytes and write to stream.

  Message
  ~~~~~~~
    Command - Byte
    Data - array of Byte
]]

local Signatures = request('^.Markers')
local SysexStartCmd = Signatures.SysexStart
local SysexEndCmd = Signatures.SysexEnd

local IsCommandByte = request('Handy.IsCommandByte')

return
  function(self, Message)
    assert_table(Message)
    assert_table(Message.Data)
    assert(is_function(self.PutByte), 'No function for PutByte().')

    local PutByte = self.PutByte

    local MessageIsSysex = not IsCommandByte(Message.Command)

    if MessageIsSysex then
      PutByte(SysexStartCmd)
    end

    PutByte(Message.Command)
    for i = 1, #Message.Data do
      PutByte(Message.Data[i])
    end

    if MessageIsSysex then
      PutByte(SysexEndCmd)
    end
  end
