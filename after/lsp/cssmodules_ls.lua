return {
  on_attach = function(client)
    -- we disable hover because:
    -- 1) on unrelated variables, it shows a `no information available` message
    -- 2) it conflicts with TS server's hover
    client.server_capabilities.hoverProvider = false
  end,
}
