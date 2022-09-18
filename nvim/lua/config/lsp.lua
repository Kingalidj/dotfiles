local keymap = vim.keymap.set

local lspconfig = require('lspconfig')

local clangd = lspconfig.clangd
local sumneko_lua = lspconfig.sumneko_lua
local rust_analyzer = lspconfig.rust_analyzer
local tsserver = lspconfig.tsserver
local pyright = lspconfig.pyright

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	keymap('n', 'gD', vim.lsp.buf.declaration, bufopts)
	keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
	keymap('n', 'K', vim.lsp.buf.hover, bufopts)
	keymap('n', 'gi', vim.lsp.buf.implementation, bufopts)
	keymap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	keymap('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	keymap('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	keymap('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	keymap('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	keymap('n', 'gr', vim.lsp.buf.references, bufopts)
	keymap('n', '<space>f', vim.lsp.buf.formatting, bufopts)

	if client.name == 'clangd' then
		keymap('n', '<Leader>d', clangd.commands.ClangdSwitchSourceHeader[1], bufopts)
	end
	-- ClangdSwitchSourceHeader
end


-- c++/c
clangd.setup {
	on_attach = on_attach
}

-- rust
rust_analyzer.setup {
	on_attach = on_attach
}

-- lua
sumneko_lua.setup {
	on_attach = on_attach,

	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

-- typescript / javascript

tsserver.setup {
	on_attach = on_attach,
}

-- python
pyright.setup {
	on_attach = on_attach,
}
