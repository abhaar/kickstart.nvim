return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
  keys = {
    { '<leader>ft', '<cmd>NvimTreeToggle<CR>', mode = 'n', silent = true },
  },
  config = function()
    require('nvim-tree').setup {
      open_on_tab = true,
      view = {
        adaptive_size = true,
      },
      update_focused_file = {
        enable = true,
        update_cwd = false, -- optional: updates Neovim's working dir to match focused file
      },
    }
  end,
}
