return {
  'neoclide/coc.nvim',
  branch = 'release',
  config = function()
    vim.g.coc_global_extensions = {
      'coc-json',
      'coc-pairs',
      'coc-prettier',
      'coc-sumneko-lua',
      'coc-tsserver',
      'coc-html',
      'coc-css',
      'coc-eslint',
    }
  end,
}
