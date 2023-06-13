--[[
  Get the value from analog pin.

  Input

    Pin - Byte - 0 for A0, 1 for A1, and so on

  Output

    Float - between (0.0, 1.0)
    OR
    Nil - in case of errors


  Note - getting analog value

    Getting analog value is weird in Firmata.

    We enabling analog reporting for given pin, disabling it next moment
    and catching analog value report for that pin.

    Similar stuff for reading digital pin value.

  Note - analog value meaning

    Actually we don't know the exact analog value. We know _range_ of
    value, but not it's exact value.

    analogRead() returns integer between 0 and 1023. It means we have 1024
    buckets numbered 0 to 1023. First bucket contains values (>= 0.0)
    and (< (1 / 1024)).

    I want to do normal math with analog value and not going to bother my
    code with scaling.

    So, for each bucket, returned float value is the _middle_ of range of
    bucket.

    This way I will never get exact 0.0 and exact 1.0. But I hope I don't
    need to.
]]

local assert_byte = request('!.number.assert_byte')

return
  function(self, Pin)
    assert_byte(Pin)

    local PinModeAnalogInput = 2
    self:CompileAndSend('SetPinMode', { Pin = Pin, Mode = PinModeAnalogInput })
    self:CompileAndSend('EnableAnalogPinReporting', { Pin = Pin } )
    local Response = self:CompileSendAndReceive('DisableAnalogPinReporting', { Pin = Pin } )

    if not is_table(Response) then
      Complain("AnalogRead(): Didn't get response to analog read request.")
      return
    end

    if (Response.Type ~= 'Analog value report') then
      Complain("AnalogRead(): Got message with unexpected type.")
      return
    end

    if (Response.Pin ~= Pin) then
      Complain(
        ('AnalogRead(): WTF?! Got analog value for another pin (%d)!'):
        format(Response.Pin)
      )
      return
    end

    --[[
      Although Firmata returns 14-bit word, analog value is 10 bits:
      from 0 to 1023.
    ]]

    local Result

    assert_integer(Response.Value)
    Result = (Response.Value + 0.5) / 1024

    return Result
  end
