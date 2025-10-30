vim.g.mapleader = " " -- space as leader
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ timeout_ms = 3000 })
end, { desc = "Format file or selection" })

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR><Esc>", { noremap = true, silent = true }) -- to disable highlighting in esc

vim.keymap.set("i", "jk", "<Esc>")

-- -- diagnostic
local diagnostic_goto = function(next, severity)
	return function()
		vim.diagnostic.jump({
			count = (next and 1 or -1) * vim.v.count1,
			severity = severity and vim.diagnostic.severity[severity] or nil,
			float = true,
		})
	end
end
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

--for floating terminal

vim.keymap.set("n", "<c-_>", "<Cmd>ToggleTerm dir=./ direction=float<CR>") -- floating terminal ctrl+/
vim.keymap.set("t", "<c-_>", "<Cmd>ToggleTerm dir=./ direction=float<CR>") -- floating terminal ctrl+/

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- WINDOW MANAGEMENT (Leader mirror of <C-w>)

-- Movement between windows
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Go to Left Window" }) -- <C-w>h
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Go to Lower Window" }) -- <C-w>j
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Go to Upper Window" }) -- <C-w>k
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Go to Right Window" }) -- <C-w>l
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Switch to Next Window" }) -- <C-w>w

-- Move window positions
vim.keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Move Window Far Left" }) -- <C-w>H
vim.keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Move Window Far Right" }) -- <C-w>L
vim.keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Move Window to Top" }) -- <C-w>K
vim.keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Move Window to Bottom" }) -- <C-w>J

-- Split windows
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split Window Below" }) -- <C-w>s
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split Window Right" }) -- <C-w>v

-- Close / swap / equalize
vim.keymap.set("n", "<leader>wc", "<C-w>c", { desc = "Close Current Window" }) -- <C-w>c
vim.keymap.set("n", "<leader>wx", "<C-w>x", { desc = "Swap Current Window" }) -- <C-w>x
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize Window Sizes" }) -- <C-w>=

-- Resize windows
vim.keymap.set("n", "<leader>w+", "<C-w>+", { desc = "Increase Window Height" }) -- <C-w>+
vim.keymap.set("n", "<leader>w-", "<C-w>-", { desc = "Decrease Window Height" }) -- <C-w>-
vim.keymap.set("n", "<leader>w>", "<C-w>>", { desc = "Increase Window Width" }) -- <C-w>>
vim.keymap.set("n", "<leader>w<", "<C-w><", { desc = "Decrease Window Width" }) -- <C-w><

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>bd<cr>", { desc = "Delete Buffer and Window" })
vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Delete Other Buffers" })

-- Delete Buffers to the Right
vim.keymap.set("n", "<leader>br", function()
	local current = vim.fn.bufnr()
	local buffers = vim.api.nvim_list_bufs()
	for _, b in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(b) and b > current then
			vim.api.nvim_buf_delete(b, {})
		end
	end
end, { desc = "Delete Buffers to the Right" })

-- Delete Buffers to the Left
vim.keymap.set("n", "<leader>bl", function()
	local current = vim.fn.bufnr()
	local buffers = vim.api.nvim_list_bufs()
	for _, b in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(b) and b < current then
			vim.api.nvim_buf_delete(b, {})
		end
	end
end, { desc = "Delete Buffers to the Left" })

-- Keymap to open Mason
vim.keymap.set("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Open Mason" })

--for git browse
vim.keymap.set({ "n", "x" }, "<leader>gB", function()
	local filepath = vim.fn.expand("%")
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	local origin_url = vim.fn.systemlist("git config --get remote.origin.url")[1]
	if origin_url:match("^https?://") then
		origin_url = origin_url:gsub("%.git$", ""):gsub("git@github%.com:", "https://github.com/")
	elseif origin_url:match("git@") then
		origin_url = origin_url:gsub("git@", "https://"):gsub(":", "/")
	end
	local relative_path = filepath:gsub("^" .. git_root .. "/", "")
	local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
	local url = string.format("%s/blob/%s/%s", origin_url, branch, relative_path)
	vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end, { desc = "Open current file on GitHub" })
