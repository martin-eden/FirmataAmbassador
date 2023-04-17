--[[
  Interface is a table with following structure:

    Handlers
    ~~~~~~~~
    {
      [Byte] = <Handler>(<Message>)
    }

  How to use

    Read one byte ~B~ from you stream.
    If there is handler at <Handlers[<B>]>, call it with message data.
    Table with parsed message is returned as result.
]]

return
  {
    [0xF9] = request('VersionReport'),
  }
