return {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup {
      background_colour = '#FF0000',
    }
  end,
}
