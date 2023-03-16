-------------
-- Options --
-------------

local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 0
opt.expandtab = true

opt.undofile = true
opt.clipboard = { "unnamedplus" }

opt.splitbelow = true
opt.splitright = true

opt.completeopt = { "menuone", "noinsert" }

opt.ignorecase = true
opt.smartcase = true

opt.number = true
opt.signcolumn = "yes"
opt.showmode = false

opt.termguicolors = true

opt.scrolloff = 2
opt.sidescrolloff = 5
opt.wrap = false

-----------------
-- Diagnostics --
-----------------

vim.diagnostic.config({
    severity_sort = true,
    float = {
        style = "minimal",
        border = "single",
    },
})

local lsp = vim.lsp

lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "single" })
lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = "single" })

--------------
-- Mappings --
--------------

local g = vim.g

g.mapleader = " "
g.maplocalleader = ","

local function set_normal_keymap(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true })
end

set_normal_keymap("K", "<C-w><C-k>")
set_normal_keymap("J", "<C-w><C-j>")
set_normal_keymap("H", "<C-w><C-h>")
set_normal_keymap("L", "<C-w><C-l>")

set_normal_keymap("<C-k>", "<Cmd>resize -6<CR>")
set_normal_keymap("<C-j>", "<Cmd>resize +6<CR>")
set_normal_keymap("<C-h>", "<Cmd>vertical resize -6<CR>")
set_normal_keymap("<C-l>", "<Cmd>vertical resize +6<CR>")

set_normal_keymap("<BS>", "<C-o>")

------------------
-- Autocommands --
------------------

local group = vim.api.nvim_create_augroup("UserConfig", {})

local function create_autocmd(event, opts)
    opts.group = group
    vim.api.nvim_create_autocmd(event, opts)
end

create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

create_autocmd("FileType", {
    pattern = { "gitcommit", "gitrebase" },
    command = "startinsert | 1",
})

-------------
-- Plugins --
-------------

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
