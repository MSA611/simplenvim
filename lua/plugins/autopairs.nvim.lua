return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = {
		"saghen/blink.cmp",
	},
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true,
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
				java = false,
			},
		})

		local blink = require("blink.cmp")

		-- Setup blink completion with autopairs integration
		blink.setup({
			keymap = {
				["<CR>"] = function(cmp)
					return cmp.accept({
						callback = require("nvim-autopairs.completion.cmp").on_confirm_done,
					})
				end,
			},
		})
	end,
}
