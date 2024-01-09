return {
  'vuki656/package-info.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  ft = { 'json' },
  config = function()
    require('package-info').setup()
    require('telescope').load_extension 'package_info'
  end,
}
