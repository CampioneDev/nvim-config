local M = {}

---Find the nearest project root by markers
---@return string|nil
local function find_project_root()
  local markers = { 'package.json', 'tsconfig.json', '.git' }
  local root = vim.fs.find(markers, { upward = true })[1]
  return root and vim.fs.dirname(root) or nil
end

---Get the node_modules path for current buffer
---@return string|nil
local function get_node_modules_path()
  local root = find_project_root()
  if not root then
    return nil
  end
  local nm = vim.fs.joinpath(root, 'node_modules')
  return vim.uv.fs_stat(nm) and nm or nil
end

--- Get the package list from pnpm or npm
--- @param global boolean|nil
--- @return table|nil
local function get_node_packages(global)
  local command = vim.fn.executable 'pnpm' and 'pnpm' or 'npm'

  -- Run `pnpm ls --json` and capture stdout
  local output = vim.fn.system { command, 'ls', '--json', global and '-g' or nil }

  if vim.v.shell_error ~= 0 then
    vim.notify(command .. ' ls failed', vim.log.levels.ERROR)
    return nil
  end

  local ok, data = pcall(vim.json.decode, output)
  if not ok then
    vim.notify('Failed to decode ' .. command .. ' output', vim.log.levels.ERROR)
    return nil
  end

  return data
end

--- Check if a package is installed
--- @param name string
--- @param global boolean|nil
--- @return boolean
local function has_node_package(name, global)
  local packages = get_node_packages(global)
  if not packages then
    return false
  end

  -- (p)npm ls --json returns an array; each element has dependencies
  for _, project in ipairs(packages) do
    local deps = project.dependencies or {}
    if deps[name] ~= nil then
      return true
    end
  end
  return false
end

--- @param packages table|nil
local function iterate_package_json(packages)
  if packages == nil then
    return {}
  end

  -- (p)npm ls --json returns an array; each element has dependencies
  local list = {}
  for _, package in ipairs(packages) do
    if package.dependencies ~= nil then
      for name, _ in pairs(package.dependencies) do
        table.insert(list, name)
      end
    end
    if package.devDependencies ~= nil then
      for name, _ in pairs(package.devDependencies) do
        table.insert(list, name)
      end
    end
  end
  -- table.sort(list)
  return list
end

local cache
---
--- @param pkg_name string
M.package_is_installed_raw = function(pkg_name)
  local nm = get_node_modules_path()
  if not nm then
    return false
  end
  local path = vim.fs.joinpath(nm, pkg_name)
  return vim.uv.fs_stat(path) and true or false
end

--- @param pkg_name string
--- @param use_cache boolean|nil
M.package_is_installed = function(pkg_name, use_cache)
  if not use_cache or cache == nil then
    cache = vim.tbl_extend('force', iterate_package_json(get_node_packages()), iterate_package_json(get_node_packages(true)))
  end

  return vim.tbl_contains(cache, pkg_name)
end

return M
