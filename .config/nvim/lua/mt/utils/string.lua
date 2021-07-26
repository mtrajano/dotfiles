local String = {}

function String.ltrim(text)
  return text:gsub('^%s+', '')
end

function String.rtrim(text)
  return text:gsub('%s+$', '')
end

function String.trim(text)
  text = String.ltrim(text)
  return String.rtrim(text)
end

return String
