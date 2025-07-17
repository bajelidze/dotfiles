local function config()
    local lspconfig = require('lspconfig')
    local util = require('lspconfig.util')
    local servers = {
        'efm',
        'clangd',
        'tsserver',
        'eslint',
        'volar',
        'lua_ls',
        'gopls',
        'golangci_lint_ls',
        'pyright',
        'yamlls',
        'jsonls',
        'cmake',
    }

    local servers_autofmt = {
        'gopls',
    }

    -- Format on save
    local function create_format_autocmd(bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'lua vim.lsp.buf.format()',
        })
    end

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    for _, server in ipairs(servers) do
        local opts = {
            capabilities = capabilities,
        }

        if server == 'efm' then
            local shellcheck = {
                lintCommand = 'shellcheck -f gcc -x -',
                lintStdin = true,
                lintFormats = {
                    '%f:%l:%c: %trror: %m',
                    '%f:%l:%c: %tarning: %m',
                    '%f:%l:%c: %tote: %m',
                },
            }

            local black = {
                formatCanRange = true,
                formatCommand =
                "black --no-color -q $(echo ${--useless:rowStart} ${--useless:rowEnd} | xargs -n4 -r sh -c 'echo --line-ranges=$(($1+1))-$(($3+1))') -",
                formatStdin = true,
            }

            local languages = {
                sh = { shellcheck },
                python = { black },
            }

            opts.init_options = {
                documentFormatting = true,
                hover = false,
                documentSymbol = false,
                codeAction = false,
                completion = false,
            }
            opts.settings = {
                filetypes = vim.tbl_keys(languages),
                rootMarkers = {
                    'package.json',
                    'pyproject.toml',
                    'Cargo.toml',
                    '.git/',
                },
                languages = languages,
            }
        elseif server == 'eslint' then
            opts.on_attach = function(_, bufnr)
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = bufnr,
                    command = 'EslintFixAll',
                })
            end
        elseif server == 'volar' then
            opts.filetypes = {
                'typescript', 'javascript', 'javascriptreact',
                'typescriptreact', 'vue', 'json',
            }
        elseif server == 'lua_ls' then
            opts.on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                    return true
                end

                client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                    },
                })

                client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
                return true
            end
        elseif server == 'gopls' then
            opts.settings = {
                gopls = {
                    gofumpt = true,
                },
            }
        elseif server == "golangci_lint_ls" then
            opts.root_dir = function(fname)
                return util.root_pattern('go.mod')(fname)
            end
        end

        for _, server_autofmt in ipairs(servers_autofmt) do
            if server == server_autofmt then
                opts.on_attach = function(_, bufnr)
                    create_format_autocmd(bufnr)
                end
                break
            end
        end

        lspconfig[server].setup(opts)
    end
end

return config
