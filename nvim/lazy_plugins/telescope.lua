local actions = require('telescope.actions')

require('telescope').setup({
    defaults = {
        default_mappings = {
            i = {
                ['<C-e>'] = actions.close,
                ['<C-n>'] = actions.move_selection_next,
                ['<C-p>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<CR>'] = actions.select_default,
                ['<C-h>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                ['<C-t>'] = actions.select_tab,
                ['<C-d>'] = actions.preview_scrolling_down,
                ['<C-u>'] = actions.preview_scrolling_up,
                ['<C-f>'] = actions.results_scrolling_down,
                ['<C-b'] = actions.results_scrolling_up,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
            },
            n = {
                ['<C-e>'] = actions.close,
                ['<Esc>'] = actions.close,
                ['q'] = actions.close,
                ['<C-n>'] = actions.move_selection_next,
                ['<C-p>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['j'] = actions.move_selection_next,
                ['k'] = actions.move_selection_previous,
                ['<CR>'] = actions.select_default,
                ['<C-h>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                ['<C-t>'] = actions.select_tab,
                ['<C-d>'] = actions.preview_scrolling_down,
                ['<C-u>'] = actions.preview_scrolling_up,
                ['<C-f>'] = actions.results_scrolling_down,
                ['<C-b'] = actions.results_scrolling_up,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                ['G'] = actions.move_to_bottom,
                ['gg'] = actions.move_to_top,
                ['L'] = actions.move_to_bottom,
                ['H'] = actions.move_to_top,
                ['M'] = actions.move_to_middle,
                ['?'] = actions.which_key,
            },
        },
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    },
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<Leader>ft', builtin.live_grep, {})
vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<Leader>fc', builtin.command_history, {})
vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})
