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
  },
  {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cpp = { "clang_format" },
      c = { "clang_format" },
    },
  },

-- lua/plugins/dap.lua
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- DAP UI
      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- C / C++ adapter (cpptools via mason)
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.stdpath("data")
          .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
      }

      dap.configurations.cpp = {
        {
          name = "Build & Launch",
          type = "cppdbg",
          request = "launch",
          program = function()
            local file = vim.fn.expand("%:p")
            local output = vim.fn.expand("%:p:r")
            vim.fn.jobstart({ "g++", file, "-g", "-o", output })
            return output
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp
    end,
  },
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
