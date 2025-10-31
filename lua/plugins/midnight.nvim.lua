return {
	{
		"dasupradyumna/midnight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme midnight")
			vim.api.nvim_set_hl(0, "Search", { bg = "#FFA500", fg = "Black" })
		end,
	},
}
