--[[
  Read from I2C device.

  Input

    Request
    ~~~~~~~
      DeviceId - Byte: 7-bit device id
      [ Offset - Byte: (Default: 0) ]
      NumBytes - Byte

  Output

    Response
    ~~~~~~~~
      DeviceId - Byte
      Offset - Byte
      Data - array of Byte
      Type - String: "I2C response"


  When we cannot read because of wrong DeviceId or NumBytes/Offset,
  TWO messages are returned from Firmata.

    First is string reply with text like "I2C: Too few bytes received".
    Second is I2C reply with data that was actually read.

    That second message is not useful, it contains not relevant data.
    So we are just eating second message if we think we got I2C read
    error.

    First message is not useful too, we are failed to read. So we are
    discarding them both and return nil as result.
]]

local IsStringResponse = request('Internals.Handy.IsStringResponse')

return
  function(self, Request)
    if not self.IsI2cInitialized then
      self:I2cInit()
    end

    local Result = self:CompileSendAndReceive('I2cRead', Request)

    if not is_nil(Result) then
      if IsStringResponse(Result) then
        -- It's I2C read error.
        -- Consume result with unusable data and return.
        Result = self:Receive()
        assert_table(Result)
        return
      end
    end

    return Result
  end
