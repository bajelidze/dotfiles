if vim.g.vscode then
    require('core/vscode')
else
    require('core/options')
    require('core/keymaps')
    require('core/plugins')
end
