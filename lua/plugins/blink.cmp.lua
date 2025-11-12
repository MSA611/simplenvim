return {
	{
		"saghen/blink.cmp",
		version = "1.*", -- stable release
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local blink = require("blink.cmp")
			blink.setup({
				keymap = {
					preset = "default",
					["<CR>"] = { "accept", "fallback" },
					["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-e>"] = { "hide", "fallback" },
					["<C-y>"] = { "select_and_accept", "fallback" },
					["<Up>"] = { "select_prev", "fallback" },
					["<Down>"] = { "select_next", "fallback" },
					["<C-k>"] = { "select_prev", "fallback_to_mappings" },
					["<C-j>"] = { "select_next", "fallback_to_mappings" },
					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },
					["<Tab>"] = { "snippet_forward", "fallback" },
					["<S-Tab>"] = { "snippet_backward", "fallback" },
				},
				appearance = {
					nerd_font_variant = "mono",
					kind_icons = {
						Text = "󰉿",
						Method = "󰆧",
						Function = "󰊕",
						Constructor = "",
						Field = "󰜢",
						Variable = "󰀫",
						Class = "󰠱",
						Interface = "",
						Module = "",
						Property = "󰜢",
						Unit = "󰑭",
						Value = "󰎠",
						Enum = "",
						Keyword = "󰌋",
						Snippet = "",
						Color = "󰏘",
						File = "󰈙",
						Reference = "󰈇",
						Folder = "󰉋",
						EnumMember = "",
						Constant = "󰏿",
						Struct = "󰙅",
						Event = "",
						Operator = "󰆕",
						TypeParameter = "",
					},
				},
				completion = {
					accept = {
						auto_brackets = { enabled = false },
					},
					menu = {
						draw = {
							treesitter = { "lsp" },
							columns = {
								{ "label" }, -- shows menu text like "return"
								{ "kind_icon", gap = 1 }, -- icon like "󰉿"
								{ "kind" }, -- kind name like "Text"
							},
						},
						-- min_width = 30,
						max_height = 100,
					},
					ghost_text = { enabled = true },
					documentation = { auto_show = true, auto_show_delay_ms = 200 },
					list = {
						selection = { preselect = false, auto_insert = false },
					},
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				fuzzy = { implementation = "prefer_rust_with_warning" },
			})
		end,
	},
}
