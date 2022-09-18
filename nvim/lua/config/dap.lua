local dap = require('dap')

dap.adapters.cppdbg = {
	id = 'cppdbg',
	type = 'executable',
	command = '/home/djahan/Applications/cpptools/extension/debugAdapters/bin/OpenDebugAD7'
}

local tauri_dev = {
	type = "cppdbg",
	request = "launch",
	name = "Tauri Development Debug",
	args = {
		"cargo",
		"build",
		"--manifest-path=./src-tauri/Cargo.toml",
		"--no-default-features",
	},
	-- task for the `beforeDevCommand` if used, must be configured in `.vscode/tasks.json`
	-- preLaunchTask = "ui:dev"
}


local tauri_prod = {
	type = "cppdbg",
	request = "launch",
	name = "Tauri Production Debug",
	args = {
		"cargo",
		"build",
		"--release",
		"--manifest-path=./src-tauri/Cargo.toml",
	},
	program = function()
		return vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/",
			"file"
		)
	end,
	cwd = '${workspaceFolder}',
	-- // task for the `beforeBuildCommand` if used, must be configured in `.vscode/tasks.json`
	-- "preLaunchTask": "ui:build"
}

-- dap.adapters.lldb = {
-- 	type = "executable",
-- 	command = "usr/bin/lldb-vscode", -- adjust as needed
-- 	name = "lldb",
-- }

-- dap.adapters.codelldb = {
--   type = 'server',
--   port = "${port}",
--   executable = {
--     command = '/home/djahan/Applications/codelldb/extension/adapter/codelldb',
--     args = {"--port", "${port}"},
--   }
-- }

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = true,
	},
}

dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp

dap.configurations.rust = {
	-- tauri_dev,
	-- tauri_prod,
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		args = {
			"cargo",
			"build",
		},
		-- program = "${file}",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = true,
	},
}

local dapui = require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
