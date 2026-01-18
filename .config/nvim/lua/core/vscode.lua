local opt = vim.opt

opt.clipboard = 'unnamedplus'

vim.g.mapleader = ' '

local noremap_setting = {
    noremap = true,
    silent = true,
}

local mappings = {
}

for _, mapping in ipairs(mappings) do
    local mode, command, action = mapping[1], mapping[2], mapping[3]
    vim.keymap.set(mode, command, function() vim.fn.VSCodeNotify(action) end, noremap_setting)
end
