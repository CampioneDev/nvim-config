--- https://www.lazyvim.org/extras/lang/typescript
--- https://banjocode.com/post/nvim/debug-node

local dap_node = function()
  local dap = require 'dap'

  if not dap.adapters['pwa-node'] then
    require('dap').adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = {
          vim.fn.expand '$MASON/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
          '${port}',
        },
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
