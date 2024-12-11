-- CC: let's disable automatic insert mode when entering terminals
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = 'term://*',
  command = 'stopinsert',
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
    -- CC: we want `stopinsert` only for pre-existing terminals, not for new ones
    vim.cmd 'startinsert'
  end,
})

if vim.fn.has 'win32' == 1 then
  -- https://github.com/akinsho/toggleterm.nvim/wiki/Tips-and-Tricks#using-toggleterm-with-powershell
  -- CC: updated with the current content in `:help shell-powershell`
  -- CC: `-NoLogo` doesn't work. We could get that by adding `/nologo` to the
  -- shell option but it breaks some things (certain plugins fail to build)
  vim.cmd [[
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
    let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
    set shellquote= shellxquote=
  ]]

  -- -- Hook into SessionWritePost to process session files
  -- vim.api.nvim_create_autocmd('SessionWritePost', {
  --   callback = require('custom.utils.win_session_file_fix').fix_session_file,
  -- })
end
