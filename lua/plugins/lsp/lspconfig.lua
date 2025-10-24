return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "saghen/blink.cmp" },
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/lazydev.nvim",                  opts = {} },
  },
  config = function()
    local blink = require("blink.cmp")
    local capabilities = blink.get_lsp_capabilities()
    vim.lsp.config("*", {
      capabilities = capabilities,
    })
  end,
}
