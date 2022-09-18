require('plugins')

local utils = require 'config.utils'
local map = utils.map

local g = vim.g

g.mapleader = ' '
g.maplocalleader = [[,]]

map('i', 'jk', '<ESC>')
map('n', '*', '*``')

map('t', 'jk', '<c-\\><c-n>')

-- telescope
map('n', '<Leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<Leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<Leader>fh', '<cmd>Telescope help_tags<cr>')
map('n', '<Leader>fa', '<cmd>lua vim.lsp.buf.code_action()<cr>')

-- map('n', '<Leader>a', '<cmd>CodeActionMenu<cr>')


-- map('n', '<Leader>fp', '<cmd>Telescope project<cr>')

map("n", "<F5>", ":lua require'dap'.continue()<CR>")
map("n", "<F3>", ":lua require'dap'.step_over()<CR>")
map("n", "<F2>", ":lua require'dap'.step_into()<CR>")
map("n", "<F4>", ":lua require'dap'.step_out()<CR>")
map("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
map("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
map("n", "<leader>db", ":lua require'dapui'.toggle()<CR>")
