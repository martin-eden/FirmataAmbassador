--[[
  Parse pins modes resonse.

  Input <Data> format - array of bytes with following structure:

    ((<Mode> <Res>) * <NumModes> 0x7F) * <NumPins>

    Mode - mode byte
    Res - resolution byte

  Output

    T
    ~
      { {<PinModeRec>, ...}, ... }

    PinModeRec
    ~~~~~~~~~~
      Mode - Byte
      Resolution - Byte

]]

return
  function(Command, Data)
    local Result =
      {
        Type = 'Pins modes',
        Data = nil,
      }

    local ParsedData = {}

    local Delimiter = 0x7F

    local CursorIndex = 1
    local CursorData = Data[CursorIndex]
    while (true) do
      if (CursorIndex == #Data + 1) then
        -- No more pins.
        break
      end

      local PinModes = {}

      while (CursorData ~= Delimiter) do
        -- Parse two data bytes:
        if (CursorIndex + 1 > #Data) then
          error(
            ('Have not enough data to parse end of message from index %d.'):
            format(CursorIndex)
          )
        end

        local ModeByte = CursorData

        CursorIndex = CursorIndex + 1
        CursorData = Data[CursorIndex]

        local ResolutionByte = CursorData

        CursorIndex = CursorIndex + 1
        CursorData = Data[CursorIndex]

        local PinModeRec =
          {
            Mode = ModeByte,
            Resolution = ResolutionByte,
          }
        table.insert(PinModes, PinModeRec)
      end

      -- Here should be delimiter.
      if (CursorData ~= Delimiter) then
        error(
          ('Expected data at index %d is 0x%02X, not 0x%02X'):
          format(CursorIndex, Delimiter, CursorData)
        )
      end

      table.insert(ParsedData, PinModes)

      CursorIndex = CursorIndex + 1
      CursorData = Data[CursorIndex]
    end

    Result.Data = ParsedData

    return Result
  end
