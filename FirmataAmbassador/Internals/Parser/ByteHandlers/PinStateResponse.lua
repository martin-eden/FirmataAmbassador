--[[
  Parse pin state response.

  Input
    {
      Command - Byte - 0x6E
      Data - array of Byte -
        [1] Pin index
        [2] Pin mode
        [3] Pin state: bits (0..6)
        ?[4] Pin state: bits (7..13)
        ?...
    }

  Output
    {
      PinIndex - Byte
      ModeName - String
      State - Byte
    }

  Note

    Here I'm refusing to fully support protocol. I'm ignoring all data
    bytes after index 3.

    First, it's another weird data format for 7-bit encoding of arbitrary
    length integer value. Also I guess only one mode uses more than
    seven bits - PWM. I'll extend code to support it when it comes to
    necessity.
]]

local GetPinModeName = request('^.^.GetBoardConfiguration.GetPinModeName')

return
  function(Command, Data)
    return
      {
        PinIndex = Data[1],
        ModeName = GetPinModeName(Data[2]),
        State = Data[3],
      }
  end
