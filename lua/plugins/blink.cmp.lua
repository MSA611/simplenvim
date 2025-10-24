return {
  "saghen/blink.cmp",
  version = "1.*", -- stable release
  build = "cargo build --release",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "saghen/blink.compat",
      optional = true,
      opts = {},
      version = "*",
    },
  },

  event = { "InsertEnter", "CmdlineEnter" },

  opts = {
    snippets = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
      preset = "default",
    },

    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },

    completion = {
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = true,
      },
    },

    sources = {
      compat = {},
      default = { "lsp", "path", "snippets", "buffer" },
    },

    cmdline = {
      enabled = true,
      keymap = {
        preset = "cmdline",
        ["<Right>"] = false,
        ["<Left>"] = false,
      },
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function()
            return vim.fn.getcmdtype() == ":"
          end,
        },
        ghost_text = { enabled = true },
      },
    },

    keymap = {
      preset = "enter",
      ["<C-y>"] = { "select_and_accept" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
    },
  },

  config = function(_, opts)
    local blink = require("blink.cmp")
    -- Remove compat key if it exists to avoid validation errors
    opts.sources.compat = nil
    blink.setup(opts)
  end,
}
