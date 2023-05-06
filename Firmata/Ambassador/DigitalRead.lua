--[[
  Get digital (boolean) value of pin.

  Something between 0V and 0.8V is FALSE,
  something between 0.8V and 2V is ANY,
  something between 2V and 5V is TRUE.

  Request
  ~~~~~~~
    Pin - Byte

  Returns
    Bool - digital value of pin (TRUE for HIGH)
      OR
    Nil - in case of errors
]]

local CompileSetPinMode = request('^.Compiler.MessageCompilers.Interface').SetPinMode
local CompileEnableReporting = request('^.Compiler.MessageCompilers.Interface').EnableDigitalPortReporting
local CompileDisableReporting = request('^.Compiler.MessageCompilers.Interface').DisableDigitalPortReporting

local assert_byte = request('!.number.assert_byte')
local GetBit = request('!.number.get_bit')

return
  function(self, Request)
    assert_table(Request)
    assert_byte(Request.Pin)

    self:Send(CompileSetPinMode({Pin = Request.Pin, Mode = 0}))

    -- Map pin number to port number. (0 .. 7) => 0, (8 .. 15) => 1, ...
    local Port = Request.Pin // 8

    self:Send(CompileEnableReporting({Port = Port}))
    self:Send(CompileDisableReporting({Port = Port}))

    local Response = self:Receive()
    if not is_table(Response) then
      self:Complain("DigitalRead(): Didn't get response to digital read request.")
      return
    end

    assert_string(Response.Type)
    assert_byte(Response.Port)
    assert_byte(Response.Value)

    if (Response.Type ~= 'Port value report') then
      self:Complain("DigitalRead(): Got message with unexpected type.")
      return
    end

    if (Response.Port ~= Port) then
      self:Complain('DigitalRead(): WTF?! Got port report for another port!')
      return
    end

    local PinBit = Request.Pin % 8
    local Result = GetBit(Response.Value, PinBit)

    return Result
  end
