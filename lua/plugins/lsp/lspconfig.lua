return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- Use blink.cmp instead of cmp-nvim-lsp here
		local blink_cmp = require("blink.cmp")
		local capabilities = blink_cmp.get_lsp_capabilities()

		local keymap = vim.keymap -- for conciseness
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				keymap.set("n", "grr", "<cmd>Telescope lsp_references<CR>", opts)
				keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
				keymap.set("n", "grd", "<cmd>Telescope lsp_definitions<CR>", opts)
				keymap.set("n", "gri", "<cmd>Telescope lsp_implementations<CR>", opts)
				keymap.set("n", "grt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
				keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, opts)
				keymap.set("n", "grn", vim.lsp.buf.rename, opts)
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				keymap.set("n", "K", vim.lsp.buf.hover, opts)
			end,
		})

		-- Use the blink_cmp capabilities for all LSP servers
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Your server specific configs unchanged ...
		vim.lsp.config("svelte", {
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		})

		vim.lsp.config("graphql", {
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		vim.lsp.config("emmet_ls", {
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		vim.lsp.config("eslint", {
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- HTML Language Server
		vim.lsp.config("html", {
			filetypes = { "html" },
			init_options = {
				provideFormatter = true,
			},
		})

		-- CSS Language Server
		vim.lsp.config("cssls", {
			filetypes = { "css", "scss", "less" },
			init_options = {
				provideFormatter = true,
			},
		})

		-- TailwindCSS Language Server
		vim.lsp.config("tailwindcss", {
			filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "svelte" },
			init_options = {
				userLanguages = {
					eelixir = "html-eex",
					eruby = "erb",
					HTML = "html",
					htmldjango = "html",
				},
			},
		})

		-- Java Language Server (jdtls)
		vim.lsp.config("jdtls", {
			filetypes = { "java" },
			root_dir = vim.fs.root(0, { "pom.xml", "build.gradle", ".git" }),
			cmd = { "jdtls" },
		})

		-- TypeScript / JavaScript Language Server
		vim.lsp.config("ts_ls", {
			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
			root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
			settings = {
				completions = {
					completeFunctionCalls = true,
				},
			},
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})
	end,
}
