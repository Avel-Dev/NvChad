return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!

 {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local capabilities = require("cmp_nvim_lsp")
            .default_capabilities()

        local on_attach = function(client, bufnr)
            client.server_capabilities.signatureHelpProvider = false
        end

        vim.lsp.config("clangd", {
            cmd = { "clangd", "--compile-commands-dir=build" },
            capabilities = capabilities,
            on_attach = on_attach,
      })

        vim.lsp.enable("clangd")
    end,
},
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd"
      }
    }
  }

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
