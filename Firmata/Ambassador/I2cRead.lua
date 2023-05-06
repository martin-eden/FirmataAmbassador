--[[
  Read from I2C device.

  Format:

    Request
    ~~~~~~~
      DeviceId - Byte
      [ Offset - Byte, Default: 0 ]
      NumBytes - Byte

  When we cannot read because of wrong DeviceId or NumBytes/Offset,
  TWO messages are returned from Firmata.

    First is string reply with text like "I2C: Too few bytes received".
    Second is I2C reply with data that was actually read.

    That second message is not useful, it contains not relevant data. So
    we just eating second message if we think we got I2C read error.

    First message is not useful too, we are failed to read. So we are
    discarding them both and return nil as result.
]]

local CompileI2cReadRequest = request('^.Compiler.MessageCompilers.Interface').I2cRead
local IsStringResponse = request('Handy.IsStringResponse')
-- local t2s = request('!.table.as_string')

return
  function(self, Request)
    -- print(('Request: %s.'):format(t2s(Request)))

    if not self.IsI2cInitialized then
      self:I2cInit()
    end

    local Command = CompileI2cReadRequest(Request)

    self:Send(Command)

    local Result = self:Receive()

    if not is_nil(Result) then
      if IsStringResponse(Result) then
        -- It's I2C read error.
        -- Consume result with unusable data and return string response.
        local NextResult = self:Receive()
        assert_table(NextResult)

        Result = nil
      end
    end

    return Result
  end
