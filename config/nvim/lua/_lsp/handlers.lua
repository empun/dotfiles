return {
  ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    -- virtual_text = {
    -- spacing = 4,
    -- prefix = ' ',
    -- },
    virtual_text = false,
    signs = true,
    underline = true,
    severity_sort = false,
    update_in_insert = false,
  }),
}
