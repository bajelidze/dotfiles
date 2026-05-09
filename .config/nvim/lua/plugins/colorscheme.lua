return {
	{
		"Mofiqul/vscode.nvim",
		priority = 1000,
		config = function()
			local vscode = require("vscode")
			vscode.setup()
			vscode.load()
		end,
	},
}
