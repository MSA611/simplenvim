vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ timeout_ms = 3000 })
end, { desc = "Format file or selection" })

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR><Esc>", { noremap = true, silent = true }) -- to disable highlighting in esc
-- commenting
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

vim.keymap.set("i", "jj", "<Esc>") --Setting jj as Esc

--quickfix list
vim.keymap.set("n", "<leader>xq", function()
	local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Quickfix List" })

-- save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- location list
vim.keymap.set("n", "<leader>xl", function()
	local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Location List" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
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

vim.keymap.set({ "n", "v" }, "y", [["+y]]) --For Copying it into the terminal
--for floating terminal

vim.keymap.set("n", "<c-_>", "<Cmd>ToggleTerm dir=./ direction=float<CR>") -- floating terminal ctrl+/
vim.keymap.set("t", "<c-_>", "<Cmd>ToggleTerm dir=./ direction=float<CR>") -- floating terminal ctrl+/

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Go to Right Window", remap = true })
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Switch to Next Window" })
vim.keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Move to Far Right Window" })
vim.keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Move to Far Left Window" })
vim.keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Move window to top " })
vim.keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Move Window Down" })
vim.keymap.set("n", "<leader>ws", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>wv", "<C-W>v", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
vim.keymap.set("n", "<leader>wx", "<C-w>x", { desc = "Swap Current Window with Next" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Equalize Window Sizes" })
vim.keymap.set("n", "<C-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-l>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-h>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- decreasing and increasing the width by <leader> > and <leader> <
vim.keymap.set("n", "<leader>w>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<leader>w<", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
-- Increase and decreasing the Height of the window
vim.keymap.set("n", "<leader>w+", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<leader>w-", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })

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

--for keymaps

local M = {}

M.lsp_keymaps = function(ev)
	local opts = { buffer = ev.buf, silent = true }
	local keymap = vim.keymap

	-- LSP Info
	opts.desc = "Lsp Info"
	keymap.set("n", "<leader>cl", "<cmd>LspInfo<CR>", opts)

	-- Definitions / References
	opts.desc = "Goto Definition"
	keymap.set("n", "gd", vim.lsp.buf.definition, opts)

	opts.desc = "References"
	keymap.set("n", "gr", vim.lsp.buf.references, opts)

	opts.desc = "Goto Implementation"
	keymap.set("n", "gI", vim.lsp.buf.implementation, opts)

	opts.desc = "Goto Type Definition"
	keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)

	opts.desc = "Goto Declaration"
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

	-- Hover / Signature
	opts.desc = "Hover"
	keymap.set("n", "K", vim.lsp.buf.hover, opts)

	opts.desc = "Signature Help"
	keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
	keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

	-- Code Actions
	opts.desc = "Code Action"
	keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

	opts.desc = "Run Codelens"
	keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, opts)

	opts.desc = "Refresh & Display Codelens"
	keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, opts)

	opts.desc = "Rename File"
	keymap.set("n", "<leader>cR", function()
		vim.lsp.util.rename_file()
	end, opts)

	opts.desc = "Rename Symbol"
	keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

	opts.desc = "Source Action"
	keymap.set("n", "<leader>cA", vim.lsp.buf.code_action, opts)

	-- References navigation
	opts.desc = "Next Reference"
	keymap.set("n", "]]", function()
		vim.lsp.buf.document_highlight()
		vim.cmd("normal! ]d")
	end, opts)
	keymap.set("n", "<A-n>", "]d", opts)

	opts.desc = "Prev Reference"
	keymap.set("n", "[[", function()
		vim.lsp.buf.document_highlight()
		vim.cmd("normal! [d")
	end, opts)
	keymap.set("n", "<A-p>", "[d", opts)
end

return M
