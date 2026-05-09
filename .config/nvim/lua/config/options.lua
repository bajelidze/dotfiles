-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local opt_local = vim.opt_local

opt.relativenumber = false
opt.hidden = true -- allow background buffers
opt.joinspaces = false -- join lines without two spaces
opt.cursorline = false

-- Disable LazyVim's default clipboard.
opt.clipboard = ""

-- Tab complete for cmd mode should autocomplete the first result immediately.
opt.wildmode = "full"

opt.swapfile = false
opt.clipboard = "unnamedplus" -- Copy-paste to the system clipboard
opt.shortmess:append("sI")
opt.mouse = "a"
opt.undodir = vim.fn.stdpath("cache") .. "/undodir"
opt.undofile = true
opt.selection = "exclusive"
opt.foldenable = false

-- UI
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.wrap = false
opt.completeopt = "menu,menuone,noselect,preview"
opt.list = true
opt.showmode = false

opt.cmdheight = 1

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.expandtab = true
opt_local.cinkeys:remove(":")
opt_local.indentkeys:remove(":")
