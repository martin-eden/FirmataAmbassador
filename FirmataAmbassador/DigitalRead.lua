--[[
  Get digital (boolean) value of pin.

  Input

    Request
    {
      Pin - Byte
    }

  Output

    Bool - digital value of pin (TRUE for HIGH)
      OR
    Nil - in case of errors

  Notes

    5V TTL logic resoultion rules are:

      V: 0.0 0.8 2.0 5.0
         ~~~~~~~ ~~~~~~~
         FALSE   TRUE
             ~~~~~~~
               ANY
]]

local assert_byte = request('!.number.assert_byte')
local GetBit = request('!.number.get_bit')

return
  function(self, Request)
    assert_table(Request)
    assert_byte(Request.Pin)

    local PinModeDigitalInput = 0
    self:CompileAndSend('SetPinMode', { Pin = Request.Pin, Mode = PinModeDigitalInput })

    -- Map pin number to port number. (0 .. 7) => 0, (8 .. 15) => 1, ...
    local Port = Request.Pin // 8

    self:CompileAndSend('EnableDigitalPortReporting', { Port = Port })
    local Response = self:CompileSendAndReceive('DisableDigitalPortReporting', { Port = Port })

    if not is_table(Response) then
      Complain("DigitalRead(): Didn't get response to digital read request.")
      return
    end

    assert_string(Response.Type)
    assert_byte(Response.Port)
    assert_byte(Response.Value)

    if (Response.Type ~= 'Port value report') then
      Complain("DigitalRead(): Got message with unexpected type.")
      return
    end

    if (Response.Port ~= Port) then
      Complain('DigitalRead(): WTF?! Got port report for another port!')
      return
    end

    local PinBit = Request.Pin % 8
    local Result = GetBit(Response.Value, PinBit)

    return Result
  end
