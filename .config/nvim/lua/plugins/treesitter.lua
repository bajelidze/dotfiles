local function is_macos()
  local config = require("meta.config")
  local config_exts = config.options.lsp.vscode_extensions
  return vim.fn.isdirectory(config_exts.macos_app_dir) ~= 0
end

local function is_fedora()
  local config = require("meta.config")
  local config_exts = config.options.lsp.vscode_extensions
  return vim.fn.isdirectory(config_exts.fedora_app_dir) ~= 0
end

local function needs_proxy()
  return not (is_macos() or is_fedora())
end

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "master",
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      -- require("nvim-treesitter.query_predicates")
    end,
    config = function()
      local configs = require("nvim-treesitter.configs")

      local install = require("nvim-treesitter.install")
      install.prefer_git = false
      install.command_extra_args = {}
      if needs_proxy() then
        install.command_extra_args = { curl = { "--proxy", "http://fwdproxy:8080" } }
      end

      -- nvim-treesitter master is archived and its query_predicates.lua handlers
      -- still treat match[capture_id] as a single TSNode. Neovim 0.11+ made it
      -- a TSNode[] always, breaking markdown hover (and other injections).
      -- Re-register the affected directives with the new array API.
      require("nvim-treesitter.query_predicates")
      local tsq = vim.treesitter.query
      local function first(m)
        if type(m) == "table" and not m.range then return m[1] end
        return m
      end
      tsq.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
        local node = first(match[pred[2]])
        if not node then return end
        local alias = vim.treesitter.get_node_text(node, bufnr):lower()
        local mt = vim.filetype.match({ filename = "a." .. alias })
        metadata["injection.language"] = mt or ({
          ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript",
        })[alias] or alias
      end, { force = true })
      tsq.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
        local node = first(match[pred[2]])
        if not node then return end
        local val = vim.treesitter.get_node_text(node, bufnr)
        local cfg = ({
          ["importmap"] = "json",
          ["module"] = "javascript",
          ["application/ecmascript"] = "javascript",
          ["text/ecmascript"] = "javascript",
        })[val]
        if cfg then
          metadata["injection.language"] = cfg
        else
          local parts = vim.split(val, "/", {})
          metadata["injection.language"] = parts[#parts]
        end
      end, { force = true })
      tsq.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
        local id = pred[2]
        local node = first(match[id])
        if not node then return end
        local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
        if not metadata[id] then metadata[id] = {} end
        metadata[id].text = string.lower(text)
      end, { force = true })

      configs.setup({
        ensure_installed = {
          "bash",
          "c",
          "c_sharp",
          "cmake",
          "comment",
          "cpp",
          "css",
          "cuda",
          "diff",
          "elixir",
          "erlang",
          "fish",
          "gitattributes",
          "go",
          "gomod",
          "graphql",
          "hack",
          "haskell",
          "hcl",
          "heex",
          "hjson",
          "html",
          "http",
          "java",
          "javascript",
          "jsdoc",
          "json",
          "json5",
          --"jsonc",
          "kotlin",
          "lua",
          "luadoc",
          "luap",
          "make",
          "markdown",
          "markdown_inline",
          "ocaml",
          "ocaml_interface",
          "perl",
          "php",
          "python",
          "query",
          "regex",
          "ruby",
          "rust",
          "sql",
          "tlaplus",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
}
