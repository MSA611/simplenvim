return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod

		local builtin = require("telescope.builtin")
		local show_hidden = false
		local respect_gitignore = true

		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")

		-- or create your custom action
		local custom_actions = transform_mod({
			open_trouble_qflist = function(prompt_bufnr)
				trouble.toggle("quickfix")
			end,
		})

		telescope.setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						width = { padding = 0 },
						height = { padding = 0 },
						preview_width = 0.5,
					},
				},
				sorting_strategy = "ascending",

				path_display = { "smart" },
				mappings = {
					n = {
						["dd"] = require("telescope.actions").delete_buffer,
						["q"] = require("telescope.actions").close,

						["<C-h>"] = function(prompt_bufnr)
							local state = require("telescope.state")
							local status = state.get_status(prompt_bufnr)
							if status.preview_win then
								vim.api.nvim_win_call(status.preview_win, function()
									vim.cmd("normal! zH") -- Scroll left
								end)
							else
								vim.cmd("TmuxNavigateLeft")
							end
						end,
						["<C-l>"] = function(prompt_bufnr)
							local state = require("telescope.state")
							local status = state.get_status(prompt_bufnr)
							if status.preview_win then
								vim.api.nvim_win_call(status.preview_win, function()
									vim.cmd("normal! zL") -- Scroll right
								end)
							else
								vim.cmd("TmuxNavigateRight")
							end
						end,
					},

					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						["<C-t>"] = trouble_telescope.open,
						["<A-h>"] = function(prompt_bufnr)
							show_hidden = not show_hidden
							actions.close(prompt_bufnr)
							builtin.find_files({ hidden = show_hidden, no_ignore = not respect_gitignore })
						end,

						["<A-i>"] = function(prompt_bufnr)
							respect_gitignore = not respect_gitignore
							actions.close(prompt_bufnr)
							builtin.find_files({ hidden = show_hidden, no_ignore = not respect_gitignore })
						end,

						["<C-h>"] = function(prompt_bufnr)
							local state = require("telescope.state")
							local status = state.get_status(prompt_bufnr)
							-- Check if we're in a Telescope picker with preview
							if status.preview_win then
								-- Scroll preview LEFT (move content to the right)
								vim.api.nvim_win_call(status.preview_win, function()
									vim.cmd("normal! zH") -- Scroll left (content moves right)
								end)
							else
								-- Use tmux navigator
								vim.cmd("TmuxNavigateLeft")
							end
						end,
						["<C-l>"] = function(prompt_bufnr)
							local state = require("telescope.state")
							local status = state.get_status(prompt_bufnr)
							-- Check if we're in a Telescope picker with preview
							if status.preview_win then
								-- Scroll preview RIGHT (move content to the left)
								vim.api.nvim_win_call(status.preview_win, function()
									vim.cmd("normal! zL") -- Scroll right (content moves left)
								end)
							else
								-- Use tmux navigator
								vim.cmd("TmuxNavigateRight")
							end
						end,
					},
				},
			},
		})

		telescope.load_extension("fzf")
	end,
	keys = {
		{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
		{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Text Grep (Root Dir)" },
		{ "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer" },
		{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		{ '<leader>f"', "<cmd>Telescope registers<cr>", desc = "Registers" },
		{ "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
		{ "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Buffer diagnostics" },
		{
			"<leader>fd",
			function()
				require("telescope.builtin").diagnostics({ bufnr = 0 })
			end,
			desc = "Current Buffer Diagnostics",
		},
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor in cwd" },
		{ "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
		{ "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
		{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
		{ "<leader>fC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
		{ "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Grep Current Buffer" },
		{ "<leader>fB", "<cmd>Telescope live_grep grep_open_files=true<cr>", desc = "Grep Open Buffers" },
		{ "<leader>f/", "<cmd>Telescope search_history<cr>", desc = "find Search History" },

		{
			"<leader>fc",
			function()
				require("telescope.builtin").find_files({
					prompt_title = "Neovim Config Files",
					cwd = vim.fn.stdpath("config"),
				})
			end,
			desc = "Find Neovim Config Files",
		},
		{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
		{ "<leader>gl", "<cmd>Telescope git_commits<cr>", desc = "Git Commits (Log)" },
	},
}
