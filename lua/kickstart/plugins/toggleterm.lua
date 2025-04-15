return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = true,
  keys = {
    { '<leader>tth', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
    { '<leader>ttf', '<cmd>ToggleTerm direction=float<cr>', desc = 'Toggle Terminal Float' },
  },
}
