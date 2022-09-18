local utils = require 'config.utils'

local opt = utils.opt
local api = vim.api

local cmd = vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo


-- Settings
local buffer = { o, bo }
local window = { o, wo }

opt('tabstop', 2, buffer)
opt('softtabstop', 2, buffer)
opt('shiftwidth', 2, buffer)

opt('number', true, window)
opt('relativenumber', true, window)
opt('incsearch', true)
opt('hlsearch', true)

opt('undofile', false)
opt('swapfile', false)
opt('backup', false)
opt('wrap', false)

opt('formatoptions', 'cro')
cmd [[
	autocmd FileType * set formatoptions-=o
]]
opt('autoindent', true)

opt('mouse', 'a')
cmd [[set completeopt=menu,menuone]]

-- Colorscheme
opt('termguicolors', true)
opt('syntax', true)


-- Theme = require('onedark')
-- Colors = Theme.get_colors()

-- Theme.setup({})

-- local handle_win_enter = function()
-- 	-- api.nvim_set_option('rnu', true)
-- 	vim.cmd [[
-- 	  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
-- 	]]
-- end

-- local window_group = api.nvim_create_augroup("WindowManagement", { clear = true })

-- api.nvim_create_autocmd("WinEnter", {
-- 	callback = handle_win_enter,
-- 	group = window_group
-- })



vim.cmd [[
	let s:clip = '/mnt/c/Windows/System32/clip.exe'
	if executable(s:clip)
		augroup WSLYank
			autocmd!
			autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
		augroup END
	endif"
]]

vim.cmd [[
	autocmd InsertLeave * silent! update
]]
