local null_ls_config = function()
  local null_ls = require 'null-ls'
  -- local helpers = require 'null-ls.helpers'
  -- local cmd_resolver = require 'null-ls.helpers.command_resolver'

  -- CC: copied and adapted from none-ls.nvim/lua/null-ls/builtins/formatting/prettierd.lua
  -- Apparently there's no need to set cwd or an args function because we're using stdin
  -- Due to a bug with prettier and plugins, it must be installed locally in the project
  -- local cc_xml_formatter = {
  --   name = 'cc_xml_formatter',
  --   filetypes = { 'xml' },
  --   method = { null_ls.methods.FORMATTING, null_ls.methods.RANGE_FORMATTING },
  --   generator = helpers.formatter_factory {
  --     command = 'prettier',
  --     dynamic_command = cmd_resolver.from_node_modules(),
  --     to_stdin = true,
  --     args = { '--parser=xml', '--plugin=@prettier/plugin-xml' },
  --   },
  -- }

  null_ls.setup {
    -- debug = true,
    sources = {
      -- null_ls.builtins.formatting.stylua,
      -- prettierd gets automatically installed by null-ls via Mason, no need to install it with npm.
      -- Initially, it wasn't working; running it from the command line I got an error about a missing /run/user/1000 directory
      -- I had to create it manually in my system:
      -- sudo mkdir -p /run/user/1000
      -- sudo chown $USER:$USER /run/user/1000
      -- sudo chmod 700 /run/user/1000
      null_ls.builtins.formatting.prettierd.with {
        -- all but js/ts files, let's use eslint for that
        filetypes = {
          -- 'javascript',
          -- 'javascriptreact',
          -- 'typescript',
          -- 'typescriptreact',
          -- 'vue',
          'css',
          'scss',
          'less',
          'html',
          'json',
          'jsonc',
          'yaml',
          'markdown',
          'markdown.mdx',
          'graphql',
          'handlebars',
        },
      },
      null_ls.builtins.formatting.shfmt,
      -- cc_xml_formatter,
    },
  }
end

return {
  'jay-babu/mason-null-ls.nvim',
  enabled = false,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'mason-org/mason.nvim',
    'nvimtools/none-ls.nvim',
  },
  config = function()
    null_ls_config()
    require('mason').setup()
    require('mason-null-ls').setup {
      automatic_installation = true,
      handlers = {},
    }
  end,
}
