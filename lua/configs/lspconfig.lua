local base = require("nvchad.configs.lspconfig")
base.defaults()

local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = vim.lsp.config

local servers = { "html", "cssls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
