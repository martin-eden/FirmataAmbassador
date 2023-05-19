local SysGetByte = request('!.file.get_byte')

return
  function(self)
    return
      function()
        local Result = SysGetByte(self.InputStream)
        if is_nil(Result) then
          -- print('Read: failed to get byte.')
        else
          -- print(('Read [0x%02X].'):format(Result))
        end
        return Result
      end
  end
