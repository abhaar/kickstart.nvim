return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup {}
  end,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { '<leader>Si', '<cmd>Lspsaga incoming_calls<cr>', desc = 'Lspsaga [I]ncoming Calls' },
    { '<leader>So', '<cmd>Lspsaga outgoing_calls<cr>', desc = 'Lspsaga [O]utgoing Calls' },
    { '<leader>Spd', '<cmd>Lspsaga peek_definition<cr>', desc = '[D]efinition' },
    { '<leader>Spt', '<cmd>Lspsaga peek_type_definition<cr>', desc = '[T]ype definition' },
    { '<leader>So', '<cmd>Lspsaga outline<cr>', desc = '[O]utline' },
  },
}
