local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazy_path) then
    vim.fn.system({
        'git',
        'clone',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazy_path,
    })
    local file = io.open(vim.fn.stdpath('config') .. '/lazy-lock.json', 'r')
    local lock = vim.json.decode(file:read('*a'))
    vim.fn.system({
        'git',
        '-C',
        lazy_path,
        'checkout',
        lock['lazy.nvim'].commit,
    })
end

vim.opt.runtimepath:prepend(lazy_path)

local function from_file(name)
    return function()
        require('lazy_plugins.' .. name)
    end
end

local specs = {
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup({
                auto_install = true,
                ensure_installed = {
                    'c',
                    'comment',
                    'editorconfig',
                    'gitcommit',
                    'gitignore',
                    'json',
                    'latex',
                    'lua',
                    'markdown',
                    'markdown_inline',
                    'query',
                    'toml',
                    'typst',
                    'vim',
                    'vimdoc',
                    'xml',
                    'yaml',
                },
                highlight = { enable = true },
            })
        end,
    },
    {
        'nmac427/guess-indent.nvim',
        config = function()
            require('guess-indent').setup({
                on_space_options = {
                    ['softtabstop'] = 0,
                    ['shiftwidth'] = 0,
                },
            })
        end,
    },
    {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup()
        end,
    },
    {
        'otavioschwanck/arrow.nvim',
        config = function()
            require('arrow').setup({
                mappings = { open_horizontal = 'h' },
                show_icons = false,
            })
        end,
    },
    {
        'ferdinandrau/lavish.nvim',
        priority = 1000,
        config = function()
            require('lavish').apply()
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        dependencies = { 'nvim-treesitter' },
        config = function()
            require('ibl').setup({
                indent = { char = '▏' },
                scope = {
                    show_exact_scope = true,
                    priority = 149,
                },
            })
        end,
    },
    {
        'NvChad/nvim-colorizer.lua',
        keys = '<Leader>c',
        config = function()
            require('colorizer').setup({
                user_default_options = {
                    names = false,
                    RRGGBBAA = true,
                    AARRGGBB = true,
                },
            })
            vim.keymap.set('n', '<Leader>c', '<Cmd>ColorizerToggle<CR>')
        end,
    },
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                ui = {
                    check_outdated_packages_on_open = false,
                    border = 'single',
                    height = 0.8,
                },
            })
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'mason.nvim' },
        config = function()
            require('mason-lspconfig').setup({ automatic_installation = true })
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        config = from_file('lualine'),
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'Telescope',
        keys = {
            '<Leader>ff',
            '<Leader>ft',
            '<Leader>fb',
            '<Leader>fc',
            '<Leader>fh',
        },
        config = from_file('telescope'),
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'garymjr/nvim-snippets',
            'rafamadriz/friendly-snippets',
            'windwp/nvim-autopairs',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
        },
        config = from_file('completion'),
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'mason-lspconfig.nvim',
            'nvim-cmp',
        },
        config = from_file('lsp'),
    },
}

local ok, local_specs = pcall(require, 'local.lazy_plugins')

if ok and type(local_specs) == 'table' then
    specs = vim.tbl_deep_extend('error', specs, local_specs)
end

require('lazy').setup(specs, {
    rocks = { enabled = false },
    change_detection = { enabled = false },
    readme = { enabled = false },
    ui = {
        wrap = false,
        border = 'single',
        backdrop = 100,
        custom_keys = {
            ['<localleader>i'] = false,
            ['<localleader>l'] = false,
            ['<localleader>t'] = false,
        },
        icons = {
            lazy = '',
            list = { '●', '•', '•', '•' },
            cmd = ':',
            config = '⚙',
            event = '!',
            favorite = '★',
            ft = '▯',
            import = '⎘',
            init = '⏻',
            keys = '⌨',
            plugin = '▢',
            require = '⭳',
            runtime = '◎',
            source = '→',
            start = '▷',
            task = '☑',
        },
    },
    dev = { path = '~/Code/nvim' },
})
