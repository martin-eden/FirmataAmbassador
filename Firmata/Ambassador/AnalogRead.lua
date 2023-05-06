--[[
  Get the value from analog pin.

  Request
  ~~~~~~~
    Pin - Byte - 0 for A0 and so on

  Returns

    Float - 0.0 < X < 1.0
      OR
    Nil - in case of errors


  Side comments below

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

local CompileSetPinMode =
  request('^.Compiler.MessageCompilers.Interface').SetPinMode
local CompileEnableAnalogReporting =
  request('^.Compiler.MessageCompilers.Interface').EnableAnalogPinReporting
local CompileDisableAnalogReporting =
  request('^.Compiler.MessageCompilers.Interface').DisableAnalogPinReporting

local assert_byte = request('!.number.assert_byte')

return
  function(self, Request)
    assert_table(Request)
    assert_byte(Request.Pin)

    self:Send(CompileSetPinMode({Pin = Request.Pin, Mode = 2}))
    self:Send(CompileEnableAnalogReporting(Request))
    self:Send(CompileDisableAnalogReporting(Request))

    local Response = self:Receive()
    if not is_table(Response) then
      self:Complain("AnalogRead(): Didn't get response to analog read request.")
      return
    end

    if (Response.Type ~= 'Analog value report') then
      self:Complain("AnalogRead(): Got message with unexpected type.")
      return
    end

    if (Response.Pin ~= Request.Pin) then
      self:Complain('AnalogRead(): WTF?! Got analog value for another pin!')
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
