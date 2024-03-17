--rvim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>`>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>`<gv=gv", { silent = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- greatest remap ever
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste without yanking (CC)' })

vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Yank to clipboard (CC)' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank to clipboard (CC)' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank to clipboard (CC)' })

vim.keymap.set('n', '<leader>df', function()
  -- vim.lsp.buf.format()
  local conform = require 'conform'
  conform.format {
    lsp_fallback = true,
    timeout_ms = 500,
  }
end, { desc = 'LSP: [D]ocument [F]ormat (CC)' })

vim.keymap.set(
  'n',
  '<leader>gC',
  -- 'silent' prevents the output of the command to be displayed as a message
  -- the usual "silent = true" doesn't work in this case
  -- 'code' arguments: -r = reuse existing window, -g = goto line:col
  ':execute "silent !code -r -g " . expand("%:p") . ":" . line(".") . ":" . col(".")<CR>',
  -- the equivalent function would be:
  -- function()
  -- 	local filename = vim.fn.expand '%:p'
  -- 	local line = vim.fn.line '.'
  -- 	local col = vim.fn.col '.'
  -- 	vim.cmd('silent !code -r -g ' .. filename .. ':' .. line .. ':' .. col)
  -- 	-- vim.cmd 'redraw!'
  -- end,
  { desc = 'Open the current file in VS Code (CC)', noremap = true, silent = true }
)
-- vim.keymap.set('n', 'gC', function()
-- 	local filename = vim.fn.expand '%:p'
-- 	local line = vim.fn.line '.'
-- 	local col = vim.fn.col '.'
-- 	vim.cmd('silent !code -r -g ' .. filename .. ':' .. line .. ':' .. col)
-- 	-- vim.cmd 'redraw!'
-- end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>gP', function()
  -- Get the clipboard content
  local clipboard = vim.fn.getreg '+'

  -- Split the clipboard content into file path, line, and column
  local parts = {}
  for part in string.gmatch(clipboard, '[^:]+') do
    table.insert(parts, part)
  end

  local path = parts[1]
  local line = parts[2]
  local column = parts[3]

  if line ~= nil then
    -- Open the file at the specified line
    vim.cmd('edit +' .. line .. ' ' .. path)
  else
    vim.cmd('edit ' .. path)
  end

  if column ~= nil then
    -- Move to the specified column
    vim.cmd('normal ' .. column .. '|')
  end
end, { desc = 'Edit the file [P]ath in the clipboard (CC)' })
