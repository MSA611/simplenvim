return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = "Mason",
		dependencies = {
			{
				"hrsh7th/cmp-nvim-lsp",
				{ "antosha417/nvim-lsp-file-operations", config = true },
				{ "folke/neodev.nvim", opts = {} },
				"williamboman/mason.nvim",
				config = true,
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			-- 🔑 Keymaps + highlights on LspAttach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("OnLspAttach", { clear = true }),
				callback = function(event)
					local opts = { buffer = event.buf, silent = true }
					local builtin = require("telescope.builtin")

					-- Info
					vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<CR>", { buffer = event.buf, desc = "LSP Info" })

					-- Goto
					vim.keymap.set(
						"n",
						"gD",
						"<cmd>Telescope lsp_definitions<CR>",
						{ buffer = event.buf, desc = "Goto Definition" }
					)

					vim.keymap.set(
						"n",
						"gI",
						"<cmd>Telescope lsp_implementations<CR>",
						{ buffer = event.buf, desc = "Goto Implementation" }
					)
					vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
					vim.keymap.set(
						"n",
						"gy",
						"<cmd>Telescope lsp_type_definitions<CR>",
						{ buffer = event.buf, desc = "Goto Type Definition" }
					)
					vim.keymap.set(
						"n",
						"gd",
						vim.lsp.buf.declaration,
						{ buffer = event.buf, desc = "Goto Declaration" }
					)

					-- Docs
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "Hover Docs" })
					vim.keymap.set(
						"n",
						"gK",
						vim.lsp.buf.signature_help,
						{ buffer = event.buf, desc = "Signature Help" }
					)
					-- vim.keymap.set(
					-- 	"i",
					-- 	"<C-k>",
					-- 	vim.lsp.buf.signature_help,
					-- 	{ buffer = event.buf, desc = "Signature Help" }
					-- )

					-- Code actions / rename
					vim.keymap.set(
						{ "n", "v" },
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ buffer = event.buf, desc = "Code Action" }
					)
					vim.keymap.set(
						"n",
						"<leader>cr",
						vim.lsp.buf.rename,
						{ buffer = event.buf, desc = "Rename Symbol" }
					)

					-- Symbols (Telescope)
					vim.keymap.set(
						"n",
						"<leader>ds",
						builtin.lsp_document_symbols,
						{ buffer = event.buf, desc = "Document Symbols" }
					)
					vim.keymap.set(
						"n",
						"<leader>ws",
						builtin.lsp_dynamic_workspace_symbols,
						{ buffer = event.buf, desc = "Workspace Symbols" }
					)

					-- Diagnostics
					vim.keymap.set(
						"n",
						"[d",
						vim.diagnostic.goto_prev,
						{ buffer = event.buf, desc = "Prev Diagnostic" }
					)
					vim.keymap.set(
						"n",
						"]d",
						vim.diagnostic.goto_next,
						{ buffer = event.buf, desc = "Next Diagnostic" }
					)
					vim.keymap.set(
						"n",
						"<leader>cd",
						vim.diagnostic.open_float,
						{ buffer = event.buf, desc = "Line Diagnostics" }
					)
					vim.keymap.set(
						"n",
						"<leader>q",
						vim.diagnostic.setloclist,
						{ buffer = event.buf, desc = "Diagnostics List" }
					)

					-- 🔦 Highlight references
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup = vim.api.nvim_create_augroup("OnLspHighlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("OnLspDetach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "OnLspHighlight", buffer = event2.buf })
							end,
						})
					end
				end,
			})

			-- Capabilities
			local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Dart
			local dartls_config = {
				cmd = { "dart", "language-server", "--protocol=lsp" },
				filetypes = { "dart" },
				init_options = {
					closingLabels = true,
					flutterOutline = true,
					onlyAnalyzeProjectsWithOpenFiles = true,
					outline = true,
					suggestFromUnimportedLibraries = true,
				},
				settings = {
					dart = {
						completeFunctionCalls = true,
						showTodos = true,
					},
				},
			}
			vim.lsp.config("dartls", dartls_config)
			vim.lsp.enable("dartls")

			-- Other servers
			local servers = {
				lua_ls = {
					capabilities = default_capabilities,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				},
				tailwindcss = {},
				cssls = {},
				html = {},
				emmet_ls = {},
				ts_ls = {},
				vuels = { filetypes = { "vue" } },
				jdtls = { filetypes = { "java" } },
				clangd = { filetypes = { "c", "cpp" } },
				gopls = {},
				pyright = {},
				rust_analyzer = {},
			}

			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server_config = servers[server_name] or {}
						server_config.capabilities =
							vim.tbl_deep_extend("force", {}, default_capabilities, server_config.capabilities or {})
						vim.lsp.config(server_name, server_config)
						vim.lsp.enable(server_name)
					end,
				},
			})
		end,
	},
}
