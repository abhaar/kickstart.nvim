return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local Terminal = require('toggleterm.terminal').Terminal

    -- Create one persisting floating terminal
    local float_term = Terminal:new {
      direction = 'float',
      hidden = true,
    }

    require('toggleterm').setup {
      persist_mode = true,
      start_in_insert = true,
      close_on_exit = true,
    }

    local function toggle_float_term()
      float_term:toggle()
    end

    vim.keymap.set('n', '<C-_>', toggle_float_term, { noremap = true, silent = true })
    vim.keymap.set('t', '<C-_>', toggle_float_term, { noremap = true, silent = true })

    vim.api.nvim_create_autocmd('TermOpen', {
      callback = function()
        vim.keymap.set('t', '<Esc><Esc>', function()
          if float_term:is_open() then
            float_term:toggle()
          end
        end, { noremap = true, silent = true, buffer = 0 })
      end,
    })
  end,
}
