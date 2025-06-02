local M = {}

---@param method string
---@param bufnr? number
function M.get_clients_supporting_method(method, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  ---@param client vim.lsp.Client
  return vim.tbl_filter(function(client)
    return client:supports_method(method)
  end, vim.lsp.get_clients { bufnr = bufnr })
end

---@param name string
---@param bufnr? number
function M.hover_from(name, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  for _, client in pairs(vim.lsp.get_clients { bufnr = bufnr }) do
    if client.name == name then
      local params = vim.lsp.util.make_position_params(0, client.offset_encoding or 'utf-16')
      local client_name = client.name
      client:request('textDocument/hover', params, function(err, result, ctx)
        local noice_ok, noice_hover = pcall(require, 'noice.lsp.hover')
        if noice_ok and noice_hover then
          noice_hover.on_hover(err, result, ctx)
        else
          local method = vim.lsp.protocol.Methods.textDocument_hover
          local handler = client.handlers[method] or vim.lsp.handlers[method]
          handler(err, result, ctx, { focus_id = 'hover:' .. client_name })
        end
      end, bufnr)
      return
    end
  end
  vim.notify("LSP '" .. name .. "' not attached", vim.log.levels.WARN)
end

return M
