--- https://www.lazyvim.org/extras/lang/typescript
--- https://banjocode.com/post/nvim/debug-node

local dap_node = function()
  local dap = require 'dap'
  local pkg = require('mason-registry').get_package 'js-debug-adapter'
  -- local receipt_opt = pkg.get_receipt(pkg)
  --
  -- ---@type InstallReceipt?
  -- local receipt
  --
  -- ---@type InstallReceipt
  -- receipt_opt.if_present(receipt_opt, function(r)
  --   receipt = r
  -- end)
  --
  -- if not receipt then
  --   return
  -- end
  --
  -- ---@type string?
  -- local cmd = select(2, next(receipt.links.bin or {}))
  --
  -- if not cmd then
  --   return
  -- end

  if not dap.adapters['pwa-node'] then
    require('dap').adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        -- 💀 Make sure to update this path to point to your installation
        args = {
          pkg.get_install_path(pkg) .. '/js-debug/src/dapDebugServer.js',
          '${port}',
        },
        -- command = cmd,
        -- args = { '${port}' },
      },
    }
  end
  if not dap.adapters['node'] then
    dap.adapters['node'] = function(cb, config)
      if config.type == 'node' then
        config.type = 'pwa-node'
      end
      local nativeAdapter = dap.adapters['pwa-node']
      if type(nativeAdapter) == 'function' then
        nativeAdapter(cb, config)
      else
        cb(nativeAdapter)
      end
    end
  end

  local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

  local vscode = require 'dap.ext.vscode'
  vscode.type_to_filetypes['node'] = js_filetypes
  vscode.type_to_filetypes['pwa-node'] = js_filetypes

  for _, language in ipairs(js_filetypes) do
    if not dap.configurations[language] then
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Node: Launch file',
          program = '${file}',
          -- cwd = vim.fn.getcwd(),
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Node: Attach',
          port = 9229,
          skipFiles = { '<node_internals>/**' },
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Node: Attach (pick process)',
          processId = require('dap.utils').pick_process,
          -- cwd = vim.fn.getcwd(),
          cwd = '${workspaceFolder}',
        },
      }
    end
  end
end

return { dap_node = dap_node }
