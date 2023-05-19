local SysPutByte = request('!.file.put_byte')

return
  function(self)
    return
      function(Byte)
        -- print(('Write [0x%02X].'):format(Byte))
        SysPutByte(self.OutputStream, Byte)
      end
  end
