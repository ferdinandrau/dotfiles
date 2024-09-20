local lualine = require('lualine')

lualine.setup({
    options = {
        icons_enabled = false,
        component_separators = '',
        section_separators = '',
        globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = { 'filename', 'diagnostics', 'branch', 'diff' },
        lualine_x = { 'encoding', 'fileformat', 'filesize' },
        lualine_y = {},
        lualine_z = { 'location' },
    },
    tabline = {
        lualine_a = {
            {
                'tabs',
                max_length = function()
                    return vim.o.columns
                end,
                mode = 2,
                show_modified_status = false,
                tabs_color = {
                    active = 'TabLineSel',
                    inactive = 'TabLine',
                },
            },
        },
    },
    extensions = {
        {
            sections = {},
            filetypes = {
                '',
                'checkhealth',
                'help',
                'lspinfo',
                'qf',
                'lazy',
                'mason',
                'TelescopePrompt',
            },
        },
    },
})
