vim.cmd.language('en_US')

vim.opt.showmode = false
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.laststatus = 3

vim.opt.title = true
vim.opt.titlestring = '%f %m - Neovim'
vim.opt.mousemodel = 'extend'
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = { 'menuone', 'noinsert' }

vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 6
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

vim.diagnostic.config({ severity_sort = true })

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.keymap.set('n', '<C-n>', '<Cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-p>', '<Cmd>cprevious<CR>zz')
vim.keymap.set('n', '<Leader>n', '<Cmd>lnext<CR>zz')
vim.keymap.set('n', '<Leader>p', '<Cmd>lprevious<CR>zz')

vim.keymap.set('n', '<Leader>q', vim.diagnostic.setqflist)
vim.keymap.set('n', '<Leader>Q', vim.diagnostic.setloclist)

vim.keymap.set({ 'i', 's' }, '<Tab>', function()
    if vim.snippet.active({ direction = 1 }) then
        return '<Cmd>lua vim.snippet.jump(1)<CR>'
    else
        return '<Tab>'
    end
end, { expr = true })

vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
    if vim.snippet.active({ direction = -1 }) then
        return '<Cmd>lua vim.snippet.jump(-1)<CR>'
    else
        return '<S-Tab>'
    end
end, { expr = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('HighlightOnYank', {}),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('EnableWrap', {}),
    pattern = {
        'text',
        'markdown',
        'tex',
        'typst',
    },
    callback = function()
        vim.opt_local.wrap = true
    end,
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

pcall(require, 'local.core')

require('lazy_plugins')
