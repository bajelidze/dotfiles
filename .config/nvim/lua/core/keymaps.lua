local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

-- General
map('i', 'jj', '<ESC>')
map('v', 'p', 'pgvy') -- Stop yanking when pasting in visual mode

-- General: Move lines in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map('i', '<C-c>', '<Esc>')

map('n', 'Q', '<nop>')

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("n", "<leader>x", "<cmd>!chmod +x %<CR>")

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)

-- Save on Ctrl+S
map('n', '<C-S>', ':update<CR>')
map('v', '<C-S>', '<C-C>:update<CR>')
map('i', '<C-S>', '<C-O>:update<CR>')

-- F key binds
map('n', '<F5>', ':setlocal spell! spelllang=de<CR>')
map('n', '<F6>', ':setlocal spell! spelllang=en_us<CR>')
map('n', '<F7>', ':set nowrap!<CR>')

-- Plugins
map('n', 'ff', '<cmd>Telescope find_files<cr>')
map('n', 'fg', '<cmd>Telescope live_grep<cr>')

map('n', '<C-K>', ':Gitsigns toggle_current_line_blame<CR>')
map('n', 'U', ':Gitsigns reset_hunk<CR>')
