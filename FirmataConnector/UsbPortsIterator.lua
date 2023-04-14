local Exists = request('!.file.exists')

local GeneratePortName =
  function(PortIndex)
    return ('/dev/ttyUSB%d'):format(PortIndex)
  end

return
  function()
    local MinPortIndex = 0
    local MaxPortIndex = 7
    local PortIndex

    return
      function()

        ::Redo::
        if (is_nil(PortIndex)) then
          PortIndex = MinPortIndex
        else
          PortIndex = PortIndex + 1
        end

        local PortName = GeneratePortName(PortIndex)
        if (not Exists(PortName)) then
          if (PortIndex == MaxPortIndex) then
            return
          else
            goto Redo
          end
        else
          return PortName
        end
      end
  end
