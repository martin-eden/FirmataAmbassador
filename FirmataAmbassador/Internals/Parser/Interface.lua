--[[
  Firmata message parser.
]]

return
  {
    Parse = request('Parse'),
    --
    ByteHandlers = request('ByteHandlers.Interface'),
    GetHandler = request('GetHandler'),
    RunHandler = request('RunHandler'),
  }
