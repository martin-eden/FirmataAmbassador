local is_byte = request('!.number.is_byte')
local OrderedPass = request('!.table.ordered_pass')

local Chars =
  {
    Top =
      {
        Left = '┏',
        Mid =
          {
            Connector = '┯',
            NoConnector = '━',
          },
        Right = '┓',
      },
    Mid =
      {
        Left = '┃',
        Mid = '│',
        Right = '┃',
      },
    Bottom =
      {
        Left = '┗',
        Mid =
          {
            Connector = '┷',
            NoConnector = '━',
          },
        Right = '┛',
      },
  }

local GetTopBottomLine =
  function(MainLine, Mid, TopBottom)
    local Result = ''

    local CodePoints = { utf8.codepoint(MainLine, 1, -1) }

    local UtfChars = {}
    for i = 1, #CodePoints do
      UtfChars[i] = utf8.char(CodePoints[i])
    end

    Result = Result .. TopBottom.Left

    for i = 2, (#UtfChars - 1) do
      local CurChar = UtfChars[i]
      if (CurChar == Mid.Mid) then
        Result = Result .. TopBottom.Mid.Connector
      else
        Result = Result .. TopBottom.Mid.NoConnector
      end
    end

    Result = Result .. TopBottom.Right

    return Result
  end

local GetTopLine =
  function(MainLine)
    return GetTopBottomLine(MainLine, Chars.Mid, Chars.Top)
  end

local GetBottomLine =
  function(MainLine)
    return GetTopBottomLine(MainLine, Chars.Mid, Chars.Bottom)
  end

local RepresentValue =
  function(Value)
    local Result

    if is_table(Value) then
      -- We assuming that <Value> is an array.
      local Terms = {}
      for i = 1, #Value do
        table.insert(Terms, ('%02X'):format(Value[i]))
      end

      local TermsStr = table.concat(Terms, ' ')

      Result = ('[%s]'):format(TermsStr)
    elseif is_byte(Value) then
      Result = ('0x%02X'):format(Value)
    else
      Result = tostring(Value)
    end
    return Result
  end

return
  function(Message)
    local Result

    local Terms = {}

    if is_nil(Message) then
      table.insert(Terms, 'NIL')
    elseif is_table(Message) then
      for k, v in OrderedPass(Message) do
        local Term = ('%s: %s'):format(k, RepresentValue(v))

        table.insert(Terms, Term)
      end
    end

    local MainLine = Chars.Mid.Left .. ' ' .. table.concat(Terms, ' ' .. Chars.Mid.Mid .. ' ') .. ' ' .. Chars.Mid.Right

    local TopLine = GetTopLine(MainLine)
    local BottomLine = GetBottomLine(MainLine)

    Result = TopLine .. '\n' .. MainLine .. '\n' .. BottomLine

    return Result
  end
