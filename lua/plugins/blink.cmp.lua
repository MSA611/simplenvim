return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" } },

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
				list = { selection = { preselect = false, auto_insert = true } },
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
