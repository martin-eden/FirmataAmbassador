--[[
  Compile data to raw format and send.

  It's simple wrapper to change common code like this

    local CompileSomething = request('Compilers.Interface').DoSomething
    self:Send(CompileSomething(Request))

  to

    self:CompileAndSend('DoSomething', Request)

  More abstract, changes "t1:f1(t2.s1(t3))" pattern to "t1:f3(s1, t3)".
]]

local Compilers = request('Compilers.Interface')

return
  function(self, CompilerName, Request)
    assert_string(CompilerName)

    local Compiler = Compilers[CompilerName]
    if is_nil(Compiler) then
      Complain(('Compiler with name "%s" is not found.'):format(CompilerName))
      return
    end

    assert_function(Compiler)

    return self:Send(Compiler(Request))
  end
