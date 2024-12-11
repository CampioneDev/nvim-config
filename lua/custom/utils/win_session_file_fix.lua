-- CC: saving sessions in Windows is faulty when it comes to terminal
-- buffers, because it saves the full path of `pwsh` (or whatever), and
-- spaces in the path (e.g. `Program Files`) break the session file. We fix
-- that by modifying the session file, removing the path and keeping the
-- command only.

local function simplify_terminal_paths_in_session_file(session_file)
  local lines = {}
  local modified = false

  for line in io.lines(session_file) do
    -- we take the first segment of the command, without possible arguments
    -- (e.g. `/nologo`)
    local shell_cmd = vim.o.shell:gmatch '([^%s]+)'()
    local pattern = 'term://(.-//[%d^:]+):.-(' .. shell_cmd .. ')%.EXE'

    -- local line_modified = false

    local new_line = line:gsub(pattern, function(base, cmd)
      modified = true
      -- line_modified = true
      -- print '-----------------'
      -- print('Original line:', line)
      -- print('base:', base)
      -- print('cmd:', cmd)
      return 'term://' .. base .. ':' .. cmd .. '.EXE'
    end)

    -- if line_modified then
    --   print('Modified line:', new_line)
    --   print '-----------------'
    -- end

    table.insert(lines, new_line)
  end

  if modified then
    -- Write the modified lines back to the session file
    -- Binary mode is needed to avoid extra newlines on Windows
    local f = io.open(session_file, 'wb')

    if f ~= nil then
      for _, l in ipairs(lines) do
        f:write(l .. '\n')
      end
      f:close()
    end
  end
end

return {
  fix_session_file = function()
    local session_file = vim.v.this_session
    if session_file and vim.fn.filereadable(session_file) == 1 then
      simplify_terminal_paths_in_session_file(session_file)
    end
  end,
}
