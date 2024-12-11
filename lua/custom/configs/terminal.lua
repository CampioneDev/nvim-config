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
  local powershell_options = {
    -- CC: `/nologo` needs to be put in the command or it won't work
    shell = (vim.fn.executable 'pwsh' == 1 and 'pwsh' or 'powershell') .. ' /nologo',
    shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
    shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
    shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
    shellquote = '',
    shellxquote = '',
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end

  -- Set terminal shell explicitly to include `-NoLogo`
  vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '*',
    callback = function()
      if vim.bo.filetype == 'terminal' then
        vim.cmd('setlocal shell=' .. vim.fn.shellescape(vim.o.shell) .. ' shellcmdflag=-NoLogo')
      end
    end,
  })

  -- -- Hook into SessionWritePost to process session files
  -- vim.api.nvim_create_autocmd('SessionWritePost', {
  --   callback = require('custom.utils.win_session_file_fix').fix_session_file,
  -- })
end
