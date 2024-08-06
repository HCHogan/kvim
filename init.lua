require 'custom.options'
require 'custom.keymaps'
require 'custom.autocommands'

local use_rocks = vim.fn.getenv 'KVIM_USE_ROCKS'

-- [[ Lazy or Rocks? ]]
if use_rocks == '1' then
  require 'rocks-nvim'
else
  require 'lazy-nvim'
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
