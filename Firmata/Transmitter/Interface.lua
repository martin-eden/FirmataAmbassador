--[[
  Firmata messages extractor and sender.

  Don't forget to set <.GetByte> and <.PutByte> to proper
  functions before use.
]]

return
  {
    -- Imported functions to get/put data. Set it before use!
    GetByte = nil,
    PutByte = nil,

    -- Main functions.
    Send = request('Send'),
    Receive = request('Receive'),

    -- Handy to override.
    Complain = function(self, Msg) print(Msg) end,
  }
