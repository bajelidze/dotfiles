-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.api.nvim_set_keymap
local cmd = vim.cmd

-- map arrow keys to pane shifts.
map("n", "<Up>", "<C-w><C-k>", { noremap = true })
map("n", "<Down>", "<C-w><C-j>", { noremap = true })
map("n", "<Left>", "<C-w><C-h>", { noremap = true })
map("n", "<Right>", "<C-w><C-l>", { noremap = true })

-- avoid mistyping write/quit
cmd("command WQ wq")
cmd("command Wq wq")
cmd("command W w")
cmd("command Q q")

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("i", "jj", "<ESC>")
map("v", "p", "pgvy") -- Stop yanking when pasting in visual mode

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("i", "<C-c>", "<Esc>")

map("n", "Q", "<nop>")

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)

map("n", "<C-S>", ":update<CR>")
map("v", "<C-S>", "<C-C>:update<CR>")
map("i", "<C-S>", "<C-O>:update<CR>")

-- Save on Ctrl+S
map("n", "<C-S>", ":update<CR>")
map("v", "<C-S>", "<C-C>:update<CR>")
map("i", "<C-S>", "<C-O>:update<CR>")

-- F key binds
map("n", "<F5>", ":setlocal spell! spelllang=de<CR>")
map("n", "<F6>", ":setlocal spell! spelllang=en_us<CR>")
map("n", "<F7>", ":set nowrap!<CR>")

map("n", "ff", "<cmd>Telescope find_files<cr>")
map("n", "fg", "<cmd>Telescope live_grep<cr>")
map("n", "gh", "<CMD>Telescope biggrep s<CR>", { desc = "[S]earch by [W]ord" })
map("n", "gf", "<CMD>Telescope myles<CR>", { desc = "[S]earch by [F]iles" })
--map("n", "gh", "<CMD>Telescope hg diff<CR>", { desc = "[S]earch by [G]it" })

-- using Meta/Alt can result in <Esc> being interpreted as Meta/Alt, which makes
-- for odd behaviors when quickly pressing <Esc> sometimes, so disable Meta
-- chords.
-- https://github.com/neovim/neovim/issues/20064
vim.keymap.del({ "n", "i", "v" }, "<A-j>")
vim.keymap.del({ "n", "i", "v" }, "<A-k>")
