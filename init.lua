if vim.g.vscode then return end

require 'core.options'
require 'core.keymaps'
require 'core.autocommands'

local use_rocks = vim.fn.getenv 'KVIM_USE_ROCKS'

-- [[ Lazy or Rocks? ]]
if use_rocks == '1' then
  require 'rocks-nvim'
else
  require 'lazy-nvim'
end
