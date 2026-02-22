return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        client.server_capabilities.signatureHelpProvider = false
      end

      vim.lsp.config("clangd", {
        cmd = { "clangd", "--compile-commands-dir=build" },
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.enable "clangd"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "cppdbg",
      },
    },
  },
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
      local dap = require "dap"
      local dapui = require "dapui"
      -- Mason setup
      require("mason").setup()
      require("mason-nvim-dap").setup {
        ensure_installed = { "cppdbg" },
        automatic_installation = true,
      }
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

      -- cppdbg adapter
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.stdpath "data" .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
      }

      dap.configurations.cpp = {
        {
          name = "Launch (CMake)",
          type = "cppdbg",
          request = "launch",
          program = function()
            local cwd = vim.fn.getcwd()
            local build_dir = cwd .. "/build"

            -- build project
            local result = vim.fn.system { "cmake", "--build", build_dir }
            if vim.v.shell_error ~= 0 then
              error("Build failed:\n" .. result)
            end

            -- find executables
            local handle = io.popen("find " .. build_dir .. " -type f -executable -not -path '*/CMakeFiles/*'")

            local executables = {}
            for file in handle:lines() do
              table.insert(executables, file)
            end
            handle:close()

            if #executables == 0 then
              error "No executable found in build directory"
            end
            if #executables == 1 then
              return executables[1]
            end
            return executables[vim.fn.inputlist(executables)]
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = true, -- important for debugging startup issues
          console = "integratedTerminal", -- FIX: shows output
        },
      }
      dap.configurations.c = dap.configurations.cpp
    end,
  },
  {
    "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        cpp = { "clang_format" },
        c = { "clang_format" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
      }
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
