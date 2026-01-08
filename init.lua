vim.g.mapleader        = " "
vim.g.maplocalleader   = " "


vim.opt.expandtab      = true
vim.opt.shiftround     = true
vim.opt.shiftwidth     = 4
vim.opt.tabstop        = 4
vim.opt.softtabstop    = 4
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.clipboard      = "unnamedplus"



-- quickly removing highlighting
vim.keymap.set('n', "<Esc>",     "<CMD>noh<CR>")
vim.keymap.set('n', "<leader>/", "gcc", { remap = true, desc = "Toggle comment"});
vim.keymap.set('v', "<leader>/", "gc",  { remap = true, desc = "Toggle comment"});


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- plugins...
local plugins = {
    { "catppuccin/nvim",  name = "catppuccin", priority = 1000 },
    { "rose-pine/neovim", name = "rose-pine",  priority = 1000 },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
                { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },
    {'nvim-treesitter/nvim-treesitter', lazy = false, build = ':TSUpdate'},
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" }, lazy = false,
    },
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, },
    { "mason-org/mason.nvim" },
    { "mason-org/mason-lspconfig.nvim", dependencies = {"mason-org/mason.nvim"} },
    { "neovim/nvim-lspconfig" },
    { "nvim-telescope/telescope-ui-select.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
    { "hrsh7th/nvim-cmp" },
    { "L3MON4D3/LuaSnip", dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" }},
    -- nvim-cmp works without this so I not putting it as a dependency. But its practically a dependency, if we want even basic auto complete
    { "hrsh7th/cmp-nvim-lsp" },
    { "folke/which-key.nvim", event = "VeryLazy" },
    { 'nvimdev/dashboard-nvim', event = 'VimEnter', dependencies = { 'nvim-tree/nvim-web-devicons' }},
    { "windwp/nvim-autopairs", event = "InsertEnter" },
    { "sphamba/smear-cursor.nvim" }
}
local opt = {}
require("lazy").setup(plugins, opt)


-- dashboard
require('dashboard').setup({
  theme = 'doom',
  config = {
    header = {
        '', '', '', '', '', '',-- top padding
        '    ██████╗ ████╗     ████╗  ███████████╗  ██████████╗  ████╗     ████╗  █████████████╗',
        '    ██████║ █████╗    ████║ ████████████╗ ████████████╗ █████╗    ████║  █████████████║',
        '    ██████║ ██████╗   ████║ ████╔═══════╝ ████╔═══████║ ██████╗   ████║  ████╔════════╝',
        '    ██████║ ███████╗  ████║ ████║         ████║   ████║ ███████╗  ████║  ████║         ',
        '    ██████║ ████╔███╗ ████║ ████████████╗ ████████████║ ████╔███╗ ████║  ███████████╗  ',
        '    ██████║ ████║╚███╗████║ ╚══════█████║ ████████████║ ████║╚███╗████║  ███████████║  ',
        '    ██████║ ████║ ╚███████║         ████║ ████╔═══████║ ████║ ╚███████║  ████║         ',
        '    ██████║ ████║  ╚██████║ ████████████║ ████║   ████║ ████║  ╚██████║  █████████████╗',
        '    ██████║ ████║   ╚█████║ ███████████╔╝ ████║   ████║ ████║   ╚█████║  █████████████║',
        '    ╚═════╝ ╚═══╝    ╚════╝ ╚══════════╝  ╚═══╝   ╚═══╝ ╚═══╝    ╚════╝  ╚════════════╝',
        '', '', '',  -- bottom padding
    },
    center = {
      { icon = '  ', desc = 'Find File                             ', key = 'f', action = 'Telescope find_files',},
      { icon = '󰥔  ', desc = 'Recent Files                          ', key = 'r', action = 'Telescope oldfiles', },
      { icon = '  ', desc = 'New File                              ', key = 'n', action = 'ene | startinsert', },
    },
    footer = { '', '"More Hours = More Better"' },
  },
})


-- Color scheme.
require("catppuccin").setup({flavour = "mocha"})
vim.cmd.colorscheme("rose-pine")


-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = 'Telescope live grep'  })
vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'Telescope buffers'    })
vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = 'Telescope help tags'  })


-- telescope-ui-select
require("telescope").setup {
    extensions = {["ui-select"] = { require("telescope.themes").get_dropdown({})}}
}
require("telescope").load_extension("ui-select")
vim.keymap.set('n', '<leader>dd', function() require("telescope.builtin").diagnostics() end, {desc = "Diagnostics"})


-- luaSnip
require("luasnip.loaders.from_vscode").lazy_load()


-- nvim-treesitter
require("nvim-treesitter").install({"c", "cpp", "lua"})
vim.opt.foldenable = false


-- nvim Auto-pair
require('nvim-autopairs').setup()


-- Smear cursor
require("smear_cursor").setup({
    time_interval = 7, -- "FPS"
    enabled = true, smear_between_buffers = true, stiffness = 0.7, trailing_stiffness = 0.45, distance_stop_animating = 0.3, trailing_exponent = 5,
    cursor_color = "#ffffff", cursor_color_insert_mode = "#ffffff", normal_bg = "#ffffff", transparent_bg_fallback_color = "#ffffff",
    legacy_computing_symbols_support = false, hide_target_hack = true, never_draw_over_target = true,
})


-- neo-tree
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })


-- mason
require("mason").setup()


-- mason lsp config
require("mason-lspconfig").setup({ensure_installed = { "lua_ls", "clangd" }})
-- print(vim.inspect(require("mason-lspconfig").get_mappings())) -- To inspect all lsp server names ( not package names ) 

-- nvim-cmp
require("cmp").setup {sources = {{ name = 'nvim_lsp' }}} -- Is this important? It works without it
vim.lsp.config("*", {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})
vim.lsp.config("clangd", {
    init_options = {fallbackFlags = { '-std=c++17' }}
})


-- To make sure the warnings and errors are displayed inline.
vim.diagnostic.config({
  virtual_text     = true,  -- THIS enables inline messages
  signs            = true,  -- keep the W/E icons if you want (or false to hide)
  underline        = true,  -- underlines the problematic code
  update_in_insert = false, -- don't spam while typing
  severity_sort    = true,  -- errors first
})


-- nvim-cmp
local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>']     = cmp.mapping.scroll_docs(-4),
        ['<C-f>']     = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>']     = cmp.mapping.abort(),
        -- ['<CR>']      = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>']      = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    }),
    experimental = {
        ghost_text = true,
    },
})


vim.keymap.set('n', 'K',     vim.lsp.buf.hover,          { desc = "Show Hover Info"     })
vim.keymap.set('n', 'gd',    vim.lsp.buf.definition,     { desc = "Go To Definition"    })
vim.keymap.set('n', 'gD',    vim.lsp.buf.declaration,    { desc = "Go To Declaration"   })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Show Signature Help" })
vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })


-- lualine
require("lualine").setup()
