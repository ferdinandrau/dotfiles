require('snippets').setup({ friendly_snippets = true })

require('nvim-autopairs').setup()

local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup({
    sources = cmp.config.sources({
        { name = 'snippets' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
    }),
    completion = { completeopt = table.concat(vim.opt.completeopt:get(), ',') },
    mapping = {
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    },
    window = { documentation = { winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None,CurSearch:None' } },
    formatting = {
        format = function(entry, item)
            local names = {
                ['snippets'] = '[Snippets]',
                ['nvim_lsp'] = '[LSP]',
                ['path'] = '[Path]',
                ['buffer'] = '[Buffer]',
            }
            item.menu = names[entry.source.name]
            return item
        end,
    },
})
