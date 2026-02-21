vim.g.mapleader        = " "
vim.g.maplocalleader   = " "
vim.opt.expandtab      = true
vim.opt.shiftround     = true
vim.opt.shiftwidth     = 4
vim.opt.tabstop        = 4
vim.opt.softtabstop    = 4
vim.opt.number         = true
vim.opt.relativenumber = false
vim.opt.clipboard      = "unnamedplus"


-- quick navigation keybinds
vim.keymap.set('n', '<Space>', '<Nop>')
vim.keymap.set({'n', 'v'}, '<C-j>', '10j',     { desc = "Go down 10 lines" })
vim.keymap.set({'n', 'v'}, '<C-k>', '10k',     { desc = "Go up 10 lines"   })
vim.keymap.set({'n', 'v'}, '<A-j>', '10<C-e>', { remap = true, silent = true, desc = "Scroll down 10 lines." })
vim.keymap.set({'n', 'v'}, '<A-k>', '10<C-y>', { remap = true, silent = true, desc = "Scroll up 10 lines."   })

vim.keymap.set('i', '<C-BS>', '<C-W>', { noremap = true, silent = true })


-- quickly removing highlighting
vim.keymap.set('n', "<leader>/", "gcc", { remap = true, desc = "Toggle comment"})
vim.keymap.set('v', "<leader>/", "gc",  { remap = true, desc = "Toggle comment"})


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
    { "catppuccin/nvim",                  priority = 1000, name = "catppuccin" },
    { "rose-pine/neovim",                 priority = 1000, name = "rose-pine" },
    { "navarasu/onedark.nvim",            priority = 1000 },
    { "nyoom-engineering/oxocarbon.nvim", priority = 1000 },
    { "aktersnurra/no-clown-fiesta.nvim", priority = 1000 },
    { "EdenEast/nightfox.nvim",           priority = 1000 },
    { "ellisonleao/gruvbox.nvim",         priority = 1000 },
    { "webhooked/kanso.nvim",             priority = 1000, lazy = false },
    { "vague-theme/vague.nvim",           priority = 1000, lazy = false },
    { "savq/melange-nvim" },
    { "sainnhe/sonokai" },
    { "projekt0n/github-nvim-theme" },
    { "uhs-robert/oasis.nvim" },
    { "rebelot/kanagawa.nvim" },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },
    {
        'nvim-treesitter/nvim-treesitter', lazy = false, build = ':TSUpdate',
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "cpp", "lua" },
            })
        end
    },
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
    { "sphamba/smear-cursor.nvim" },
    { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "smjonas/inc-rename.nvim" },
    { "mg979/vim-visual-multi" },
    { "abecodes/tabout.nvim", lazy = false },
    { "superNGA/AlignEm.nvim" }, -- This is the good one.
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
        opts = {},
    },
    {
        "zaldih/themery.nvim",
        lazy   = false,
        config = function()
            require("themery").setup({
                themes = { -- color schemes :)
                    "blue",                      "carbonfox",                  "catppuccin",              "catppuccin-frappe",
                    "catppuccin-latte",          "catppuccin-macchiato",       "catppuccin-mocha",        "darkblue",
                    "dawnfox",                   "dayfox",                     "default",                 "delek",
                    "desert",                    "duskfox",                    "elflord",                 "evening",
                    "github_dark",               "github_dark_colorblind",     "github_dark_default",     "github_dark_dimmed",
                    "github_dark_high_contrast", "github_dark_tritanopia",     "github_light",            "github_light_colorblind",
                    "github_light_default",      "github_light_high_contrast", "github_light_tritanopia", "gruvbox",
                    "habamax",                   "industry",                   "kanagawa",                "kanagawa-dragon",
                    "kanagawa-lotus",            "kanagawa-wave",              "kanso",                   "kanso-ink",
                    "kanso-mist",                "kanso-pearl",                "kanso-zen",               "koehler",
                    "lunaperche",                "melange",                    "miniautumn",              "minicyan",
                    "minischeme",                "minispring",                 "minisummer",              "miniwinter",
                    "morning",                   "murphy",                     "nightfox",                "no-clown-fiesta",
                    "no-clown-fiesta-dark",      "no-clown-fiesta-dim",        "no-clown-fiesta-light",   "nordfox",
                    "oasis",                     "oasis-abyss",                "oasis-cactus",            "oasis-canyon",
                    "oasis-desert",              "oasis-dune",                 "oasis-lagoon",            "oasis-midnight",
                    "oasis-mirage",              "oasis-night",                "oasis-rose",              "oasis-sol",
                    "oasis-starlight",           "oasis-twilight",             "onedark",                 "oxocarbon",
                    "pablo",                     "peachpuff",                  "quiet",                   "randomhue",
                    "retrobox",                  "ron",                        "rose-pine",               "rose-pine-dawn",
                    "rose-pine-main",            "rose-pine-moon",             "shine",                   "slate",
                    "sonokai",                   "sorbet",                     "terafox",                 "torte",
                    "unokai",                    "vague",                      "vim",                     "wildcharm", "zaibatsu", "zellner" },
                livePreview = true,
            })
        end
    }
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


local AlignEm = require("AlignEm")
AlignEm.setup()
vim.keymap.set("n", "<Esc>", function() vim.cmd("noh") AlignEm.RemoveAllCursors() end, { desc = "AlignEm: Remove all cursors" })
vim.keymap.set("n", "<C-0>", AlignEm.AddCursor,                                        { desc = "AlignEm: Add cursor" })
vim.keymap.set("n", "<C-m>", AlignEm.AlignAllCursors,                                  { desc = "AlignEm: Align all cursors" })

-- Color scheme.
require("onedark").setup({style = "warmer"})
vim.cmd.colorscheme("onedark")


-- Themery.nvim 
vim.keymap.set("n", "<leader>tt", ":Themery<CR>", { desc = "Theme switcher" })

-- Tabout
require('tabout').setup({})


-- bufferline
vim.opt.termguicolors = true
require("bufferline").setup{}
vim.keymap.set('n', '<Tab>',   "<Cmd>b#<CR>",    { desc = "Go to last buffer" })
vim.keymap.set('n', '<S-Tab>', "<Cmd>bnext<CR>", { desc = "Go to next buffer" })


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
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local f  = ls.function_node
local i  = ls.insert_node
ls.add_snippets("all",{
    s("wall", {
        t({
            "///////////////////////////////////////////////////////////////////////////",
            "///////////////////////////////////////////////////////////////////////////",
        })
    }),
    s("wallasm", {
        t({
            ";//////////////////////////////////////////////////////////////////////////",
            ";//////////////////////////////////////////////////////////////////////////",
        })
    }),
    s("walllua", {
        t({
            "--/////////////////////////////////////////////////////////////////////////",
            "--/////////////////////////////////////////////////////////////////////////",
        })
    }),
    s("dochdr", {
    t("//========================================================================="),
    t({"", "//                      "}),
    i(1, "Title"),
    t({"", "//========================================================================="}),
    t({"", "// by      : INSANE"}),
    t({"", "// created : "}),
    f(function() return os.date("%d/%m/%Y") end), -- Date
    t({"", "//", "// purpose : "}),
    i(2, "Purpose"),
    t({"", "//-------------------------------------------------------------------------"}),
    t({""}),
    i(0),
  }),
})
require("luasnip.loaders.from_vscode").lazy_load()


-- nvim-treesitter
vim.opt.foldenable = false


-- nvim Auto-pair
require('nvim-autopairs').setup()


-- inc-rename
require("inc_rename").setup({});
vim.keymap.set("n", "<leader>rn", function() return ":IncRename " .. vim.fn.expand("<cword>") end, { expr = true }, { desc = "Rename symbols under cursor" })


-- Smear cursor
-- Not required with neovide.
-- require("smear_cursor").setup({
--     time_interval = 7, -- "FPS"
--     enabled = true, smear_between_buffers = true, stiffness = 0.7, trailing_stiffness = 0.45, distance_stop_animating = 0.3, trailing_exponent = 5,
--     cursor_color = "#ffffff", cursor_color_insert_mode = "#ffffff", normal_bg = "#ffffff", transparent_bg_fallback_color = "#ffffff",
--     legacy_computing_symbols_support = false, hide_target_hack = true, never_draw_over_target = true,
--     smear_diagonally = true, smear_horizontally = true, smear_vertically = true
-- })


-- neo-tree
require("oil").setup({view_options = {show_hidden = true}})
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
    -- std::format is fine with C++ 17 on msvc but not anywhere else, so we use c++ 20, but I really don't want to :( I like 17
    -- init_options = {fallbackFlags = { '-std=c++20' }},

    cmd = {
        "clangd",
        "--header-insertion=never"
    }
})
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT", -- Neovim uses LuaJIT
            },
            diagnostics = {
                globals = { "vim" }, -- Tell it vim is a global
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
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
local luasnip = require("luasnip")
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
        ['<Tab>']     = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        -- Jumping between placeholders
        ['<C-l>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<C-h>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
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


-- Gotta delete H's keybind before setting it to Hover info
-- vim.keymap.del('n', 'H')
vim.keymap.set('n',        'H',          vim.lsp.buf.hover,          { desc = "Show Hover Info"     })
vim.keymap.set('n',        'gd',         vim.lsp.buf.definition,     { desc = "Go To Definition"    })
vim.keymap.set('n',        'gD',         vim.lsp.buf.declaration,    { desc = "Go To Declaration"   })
vim.keymap.set('n',        '<C-h>',      vim.lsp.buf.signature_help, { desc = "Show Signature Help" })
vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action,    { desc = "Code Action" })


-- lualine
require("lualine").setup()
