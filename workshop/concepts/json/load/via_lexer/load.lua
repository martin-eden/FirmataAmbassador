return
  function(self, s)
    local is_ok, result = self:load_value(s, 1)
    if is_ok then
      return result
    end
  end
