return {
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				names = false, -- disable named colors like "blue"
				tailwind = true, -- also highlight Tailwind colors properly
			},
		},
	},
}
