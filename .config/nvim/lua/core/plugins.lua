local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = {
        {
            'Mofiqul/vscode.nvim',
            priority = 1000,
            config = function()
                local vscode = require('vscode')
                vscode.setup()
                vscode.load()
            end,
        },

        {
            'neovim/nvim-lspconfig',
            dependencies = {
                'hrsh7th/cmp-nvim-lsp',
                'williamboman/mason-lspconfig.nvim',
            },
            config = require('plugins/lspconfig'),
        },

        {
            'creativenull/efmls-configs-nvim',
            dependencies = { 'neovim/nvim-lspconfig' },
        },

        {
            'L3MON4D3/LuaSnip',
            version = 'v2.*',
            build = 'make install_jsregexp',
        },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },

        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'L3MON4D3/LuaSnip',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'hrsh7th/cmp-nvim-lsp-signature-help',
            },
            config = require('plugins/nvim-cmp'),
        },

        {
            'williamboman/mason.nvim',
            config = true,
        },

        {
            'williamboman/mason-lspconfig.nvim',
            dependencies = { 'williamboman/mason.nvim' },
            config = true,
            opts = {
                ensure_installed = {
                    'clangd', 'efm', 'lua_ls', 'pyright', 'gopls', 'ts_ls', 'rust_analyzer',
                }
            },
        },

        {
            'numToStr/Comment.nvim',
            opts = {
                toggler = {
                    line = '<C-_>',
                    block = nil,
                },
                opleader = {
                    line = '<C-_>',
                    block = nil,
                },
                mappings = {
                    extra = false,
                },
            },
        },

        {
            'lewis6991/gitsigns.nvim',
            config = true,
        },

        {
            'nvim-treesitter/nvim-treesitter',
            opts = {
                ensure_installed = {
                    'bash', 'c', 'cpp', 'html', 'css', 'javascript',
                    'typescript', 'json', 'json5', 'yaml', 'vue', 'tsx',
                    'lua', 'python', 'go', 'rust', 'vim', 'csv', 'xml',
                    'git_config', 'git_rebase', 'gitcommit', 'gitignore',
                    'gitattributes', 'gomod', 'gosum', 'haskell', 'jq',
                    'make', 'markdown', 'markdown_inline', 'ninja',
                    'sql', 'ssh_config', 'terraform',
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            },
            config = function(_, opts)
                require('nvim-treesitter.configs').setup(opts)
            end,
        },

        { 'nvim-lua/plenary.nvim' },
        { 'nvim-lua/popup.nvim' },
        { 'nvim-tree/nvim-web-devicons' },
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
                'nvim-lua/popup.nvim',
                'nvim-tree/nvim-web-devicons',
            },
        },

        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            opts = {
                options = {
                    theme = 'vscode',
                    section_separators = {},
                },
            },
        },

        {
            'windwp/nvim-autopairs',
            event = 'InsertEnter',
            config = true,
        },

        {
            'petertriho/nvim-scrollbar',
            opts = {
                handle = { color = '#343434' },
            },
        },

        { 'mattn/vim-goimports' },
    },
})
