return
  {
    -- Imported functions to get/put data. Should be set externally.
    GetByte = nil,
    PutByte = nil,

    -- Main functions.
    Send = request('Send'),
    Receive = request('Receive'),
  }
