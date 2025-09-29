-- return {
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		event = { "BufReadPre", "BufNewFile" },
-- 		cmd = "Mason",
-- 		dependencies = {
-- 			{
-- 				"williamboman/mason.nvim",
-- 				config = true,
-- 				opts = {
-- 					ui = {
-- 						icons = {
-- 							package_pending = " ",
-- 							package_installed = "󰄳 ",
-- 							package_uninstalled = " ",
-- 						},
-- 					},
-- 				},
-- 			},
-- 			"williamboman/mason-lspconfig.nvim",
-- 			"WhoIsSethDaniel/mason-tool-installer.nvim",
-- 		},
-- 		config = function()
-- 			-- LSP Attach autocmd for document highlights
-- 			vim.api.nvim_create_autocmd("LspAttach", {
-- 				group = vim.api.nvim_create_augroup("OnLspAttach", { clear = true }),
-- 				callback = function(event)
-- 					local client = vim.lsp.get_client_by_id(event.data.client_id)
-- 					if client and client.server_capabilities.documentHighlightProvider then
-- 						local highlight_augroup = vim.api.nvim_create_augroup("OnLspHighlight", { clear = false })
-- 						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
-- 							buffer = event.buf,
-- 							group = highlight_augroup,
-- 							callback = vim.lsp.buf.document_highlight,
-- 						})
-- 						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
-- 							buffer = event.buf,
-- 							group = highlight_augroup,
-- 							callback = vim.lsp.buf.clear_references,
-- 						})
-- 						vim.api.nvim_create_autocmd("LspDetach", {
-- 							group = vim.api.nvim_create_augroup("OnLspDetach", { clear = true }),
-- 							callback = function(event2)
-- 								vim.lsp.buf.clear_references()
-- 								vim.api.nvim_clear_autocmds({ group = "OnLspHighlight", buffer = event2.buf })
-- 							end,
-- 						})
-- 					end
-- 				end,
-- 			})
--
-- 			local lspconfig = require("lspconfig")
-- 			local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
--
-- 			-- Dart LSP Setup
-- 			lspconfig.dartls.setup({
-- 				cmd = { "dart", "language-server", "--protocol=lsp" },
-- 				filetypes = { "dart" },
-- 				init_options = {
-- 					closingLabels = true,
-- 					flutterOutline = true,
-- 					onlyAnalyzeProjectsWithOpenFiles = true,
-- 					outline = true,
-- 					suggestFromUnimportedLibraries = true,
-- 				},
-- 				settings = {
-- 					dart = {
-- 						completeFunctionCalls = true,
-- 						showTodos = true,
-- 					},
-- 				},
-- 			})
--
-- 			local servers = {
-- 				lua_ls = {
-- 					capabilities = default_capabilities,
-- 					settings = {
-- 						Lua = {
-- 							diagnostics = { globals = { "vim" } },
-- 							workspace = {
-- 								library = {
-- 									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
-- 									[vim.fn.stdpath("config") .. "/lua"] = true,
-- 								},
-- 							},
-- 						},
-- 					},
-- 				},
-- 				vuels = { filetypes = { "vue" } },
-- 				jdtls = { filetypes = { "java" } },
-- 				clangd = { filetypes = { "c", "cpp" } },
-- 				gopls = {},
-- 				pyright = {},
-- 				rust_analyzer = {},
-- 			}
--
-- 			require("mason").setup()
--
-- 			local ensure_installed = vim.tbl_keys(servers)
-- 			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
--
-- 			require("mason-lspconfig").setup({
-- 				handlers = {
-- 					function(server_name)
-- 						local server_config = servers[server_name] or {}
-- 						server_config.capabilities =
-- 							vim.tbl_deep_extend("force", {}, default_capabilities, server_config.capabilities or {})
-- 						lspconfig[server_name].setup(server_config)
-- 					end,
-- 				},
-- 			})
-- 		end,
-- 	},
-- }
--
--perplexity generated

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = "Mason",
		dependencies = {
			{
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
		},
		config = function()
			-- LSP Attach autocmd for document highlights
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("OnLspAttach", { clear = true }),
				callback = function(event)
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

			local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Dart LSP config unchanged, just replace setup with new api:
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
