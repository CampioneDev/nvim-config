return {
  settings = {
    -- the key is `python` when using pyright
    basedpyright = {
      -- NOTE: this was only needed with pyright... basedpyright seems to
      -- recognize venvs automatically
      --
      -- if an environment is activated before starting, it will be used:
      -- pythonPath = vim.fn.exepath 'python',
      analysis = {
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
}
