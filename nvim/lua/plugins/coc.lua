local function contains(table, needle)
  for i,value in ipairs(table) do
    if (value == needle) then
      return true
    end
  end

  return false
end

local function show_documentation()
  local filetype = vim.bo.filetype

  if contains({'vim', 'help'}, filetype) then
    vim.cmd('execute "h " .. expand("<cword>")')
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.cmd('call CocActionAsync("doHover")')
  else
    print('need to check this scenario')
    vim.cmd('execute "!" . &keywordprg . " " . expand("<cword>")')
  end
end

return {
  show_documentation = show_documentation
}
