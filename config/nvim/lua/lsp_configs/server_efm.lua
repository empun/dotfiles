return function(nvim_lsp, on_attach, handlers)
  -- JS Linter
  local eslint = {
    lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
    lintStdin = true,
    lintFormats = { '%f:%l:%c: %m' },
    lintIgnoreExitCode = true,
    formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}', -- it'd also run prettier as plugin
    formatStdin = true,
  }

  -- Formatter
  local prettierd = {
    formatCommand = 'prettierd ${INPUT}',
    formatStdin = true,
  }
  local prettierdHtml = {
    formatCommand = 'prettierd ${INPUT}',
    formatStdin = true,
    env = {
      string.format('PRETTIERD_DEFAULT_CONFIG=%s', vim.fn.expand '~/.config/prettierd/prettierrc.json'),
    },
  }
  local lua_stylua = { formatCommand = 'stylua -s -', formatStdin = true }

  local efm_root_markers = { 'package.json', '.git/' }

  local efm_languages = {
    css = { prettierd },
    scss = { prettierd },
    sass = { prettierd },
    less = { prettierd },
    graphql = { prettierd },
    vue = { prettierd },
    html = { prettierdHtml },
    svelte = { prettierd },
    yaml = { prettierd },
    toml = { prettierd },
    json = { prettierd },
    markdown = { prettierd },
    lua = { lua_stylua },
    javascript = { eslint },
    typescript = { eslint },
    javascriptreact = { eslint },
    typescriptreact = { eslint },
    ['typescript.tsx'] = { eslint },
    ['javascript.jsx'] = { eslint },
  }

  nvim_lsp.efm.setup {
    init_options = { documentFormatting = true },
    filetypes = vim.tbl_keys(efm_languages),
    root_dir = nvim_lsp.util.root_pattern(unpack(efm_root_markers)),
    settings = { rootMarkers = efm_root_markers, languages = efm_languages },
    on_attach = on_attach,
    handlers = handlers,
  }
end
