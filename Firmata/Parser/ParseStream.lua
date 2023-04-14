local Markers = request('^.Markers')
local ExplodeVersionChunk = request('ExplodeVersionChunk')
local t2s = request('!.table.as_string')

return
  function(InputStream)
    local Buffer = ''
    local Result

    while (true) do
      local CurByte = InputStream:read(1):byte()

      if (is_nil(CurByte)) then
        print('End of stream?')
        break
      end

      Buffer = Buffer .. string.char(CurByte)

      if (CurByte < 0x80) then
        print('Not a command byte. Ignoring.')
        Buffer = Buffer:sub(1, -2)
      else
        if (CurByte == Markers.SysexStart) then
          print('SysexStart. Reading till SysexEnd.')
          while (true) do
            CurByte = InputStream:read(1):byte()

            if (is_nil(CurByte)) then
              print('End of stream?')
              break
            end

            Buffer = Buffer .. string.char(CurByte)

            if (CurByte == Markers.SysexEnd) then
              print('Got SysexEnd. Done.')
            end
          end
        else
          print('Not a Sysex. Custom read.')

          if ((CurByte >= 0x90) and (CurByte <= 0x9F)) then
            print('Digital port value report.')
            Buffer = Buffer .. InputStream:read(2)
          end

          if ((CurByte >= 0xE0) and (CurByte <= 0xEF)) then
            print('Analogue port value report.')
            Buffer = Buffer .. InputStream:read(2)
          end

          if (CurByte == 0xF9) then
            print('Version report.')
            Buffer = Buffer .. InputStream:read(2)
            Result = ExplodeVersionChunk(Buffer)
          end
        end
        break
      end
    end

    if not is_nil(Result) then
      print('Parsed', t2s(Result))
    end

    return Result
  end
