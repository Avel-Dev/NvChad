require "nvchad.mappings"

-- add yours here
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("v", "S", "^", { noremap = true })
vim.keymap.set("v", "D", "$", { noremap = true })
vim.keymap.set("n", "S", "^", { desc = "Go to line start" })
vim.keymap.set("n", "D", "$", { desc = "Go to line end" })
vim.keymap.set("n", "J", "5j", { desc = "Move down faster" })
vim.keymap.set("n", "K", "5k", { desc = "Move up faster" })

vim.keymap.set("n", "<leader>vs", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>hs", ":split<CR>", { desc = "Horizontal split" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up" })

vim.keymap.set('n', '<leader>d', function()
	vim.diagnostic.open_float()
end, { desc = 'Show diagnostics under cursor' })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show references" })


vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })

vim.keymap.set("n", "<leader>e", ":Ex<CR>", { desc = "explorer" })
vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end)
vim.keymap.set("n", "<leader>de", function() require("dapui").eval() end, { desc = "Evaluate expression" })

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y') -- yank to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p') -- paste from clipboard

vim.keymap.set("n", "<leader>tt", ":belowright split | terminal<CR>", { silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("n", "<leader>tv", ":vsplit | terminal<CR>", { silent = true })
vim.keymap.set("n", "<leader>tT", ":tab terminal<CR>", { silent = true })

vim.keymap.set("n", "<M-h>", ":vertical resize -2<CR>", { desc = "Resize left" })
vim.keymap.set("n", "<M-l>", ":vertical resize +2<CR>", { desc = "Resize right" })
vim.keymap.set("n", "<M-j>", ":resize -2<CR>", { desc = "Resize down" })
vim.keymap.set("n", "<M-k>", ":resize +2<CR>", { desc = "Resize up" })

vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>x", ":bd<CR>")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
