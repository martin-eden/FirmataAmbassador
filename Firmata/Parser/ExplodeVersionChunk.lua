return
  function(chunk)
    assert_string(chunk)
    assert(#chunk == 3)
    assert(chunk:sub(1, 1) == '\xF9')

    return
      {
        Type = 'Version',
        Major = chunk:sub(2, 2):byte(),
        Minor = chunk:sub(3, 3):byte(),
      }
  end
