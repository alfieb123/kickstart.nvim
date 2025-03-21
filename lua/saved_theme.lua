local theme_file = vim.fn.stdpath 'data' .. '/last_colorscheme.txt'

local M = {}

function M.save(theme)
  local f = io.open(theme_file, 'w')
  if f then
    f:write(theme)
    f:close()
  end
end

function M.load()
  local f = io.open(theme_file, 'r')
  if f then
    local theme = f:read '*l'
    f:close()
    return theme
  end
end

return M
