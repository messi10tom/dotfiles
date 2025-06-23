return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "pyright",
        "clangd",
        "lua_ls",
        "html",
        "cssls",
        "ts_ls", 
        "eslint",
        "tailwindcss", 
      },
    })

    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local servers = {
      pyright = {
        settings = {
          python = {
            pythonPath = vim.fn.exepath('python'),
            analysis = {
              extraPaths = {}
            }
          }
        }
      },
      clangd = {
       capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
          fallbackFlags = { '-std=c++23' },
        },



      },
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      },
      html = {},
      cssls = {},
      ts_ls = {},
      eslint = {},
      tailwindcss = {},
      rust_analyzer = {
        settings = {
          ["rust_analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
          },
        },
      },
    }

    for name, opts in pairs(servers) do
      opts.capabilities = capabilities
      lspconfig[name].setup(opts)
    end
  end,
}

