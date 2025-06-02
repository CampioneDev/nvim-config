local M = {}

function M.project_has_stylelint_cfg(start_dir)
  start_dir = start_dir or vim.loop.cwd()

  -- nearest dir that has any stylelint file
  local hit = vim.fs.find({
    '.stylelintrc',
    '.stylelintrc.json',
    '.stylelintrc.yaml',
    '.stylelintrc.yml',
    '.stylelintrc.js',
    '.stylelintrc.cjs',
    'stylelint.config.js',
    'stylelint.config.cjs',
    -- include package.json only if you parse it; otherwise skip to avoid false positives
  }, { upward = true, path = start_dir, stop = vim.uv.os_homedir() })[1]

  if not hit then
    return false
  end
  return true
end

return M
