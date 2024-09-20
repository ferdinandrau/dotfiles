require('lspconfig.ui.windows').default_options.border = 'single'

local servers = {
    ['lua_ls'] = {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                workspace = {
                    checkThirdParty = false,
                    library = { vim.env.VIMRUNTIME },
                },
                hint = {
                    enable = true,
                    arrayIndex = 'Disable',
                    semicolon = 'Disable',
                },
            },
        },
    },
    'clangd',
    'marksman',
    'texlab',
    'typst_lsp',
}

local ok, local_servers = pcall(require, 'local.language_servers')

if ok and type(local_servers) == 'table' then
    servers = vim.tbl_deep_extend('force', servers, local_servers)
end

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for key, value in pairs(servers) do
    if type(key) == 'string' and type(value) == 'table' then
        value.capabilities = capabilities
        lspconfig[key].setup(value)
    else
        lspconfig[value].setup({ capabilities = capabilities })
    end
end

local group = vim.api.nvim_create_augroup('SetLspKeymaps', {})

vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', '<LocalLeader>r', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<LocalLeader>a', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<LocalLeader>f', vim.lsp.buf.format, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gb', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<LocalLeader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<LocalLeader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<LocalLeader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<LocalLeader>i', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end)
    end,
})

vim.api.nvim_create_autocmd('LspDetach', {
    group = group,
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.del('n', '<LocalLeader>r', opts)
        vim.keymap.del('n', '<LocalLeader>a', opts)
        vim.keymap.del('n', '<LocalLeader>f', opts)
        vim.keymap.del('n', 'gd', opts)
        vim.keymap.del('n', 'gD', opts)
        vim.keymap.del('n', 'gb', opts)
        vim.keymap.del('n', 'gi', opts)
        vim.keymap.del('n', 'gr', opts)
        vim.keymap.del('n', '<C-k>', opts)
        vim.keymap.del('n', '<LocalLeader>wa', opts)
        vim.keymap.del('n', '<LocalLeader>wr', opts)
        vim.keymap.del('n', '<LocalLeader>wl', opts)
        vim.keymap.del('n', '<LocalLeader>i', opts)
    end,
})
