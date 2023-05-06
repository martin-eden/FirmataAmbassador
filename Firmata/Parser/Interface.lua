--[[
  Firmata message parser.
]]

return
  {
    Parse = request('Parse'),
    --
    BaseHandlers = request('ByteHandlers.Interface'),
    SysexHandlers = request('ByteHandlers.Sysex.Interface'),
    GetHandler = request('GetHandler'),
    RunHandler = request('RunHandler'),
    --
    Complain =
      function(self, Str)
        -- print('___')
        print(Str)
        -- print(debug.traceback())
        -- print('===')
      end,
  }
