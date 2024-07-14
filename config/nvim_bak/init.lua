require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- Adding neoscroll for smooth scrolling
require('neoscroll').setup()

-- Adding transparent for transparent background
-- require("transparent").setup({ -- Optional, you don't have to run setup.
--   groups = { -- table: default groups
--     'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
--     'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
--     'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
--     'SignColumn', 'CursorLineNr', 'EndOfBuffer',
--   },
--   extra_groups = {}, -- table: additional groups that should be cleared
--   exclude_groups = {}, -- table: groups you don't want to clear
-- })

-- custom commands 

vim.cmd "set nocursorline"
vim.cmd "set relativenumber"

vim.api.nvim_set_keymap('n', '<C-t>', ':Telescope themes<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-i>', ':Nvdash<CR>', { noremap = true, silent = true })

-- Disable Word Wrap 
vim.opt.wrap = false
vim.cmd.colorscheme "catppuccin"
