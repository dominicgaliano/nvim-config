local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

-- local formatting = null_ls.builtins.formatting
-- local diagnostic = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- formatting.prettierd,
    -- diagnostic.eslint_d
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
  }
})
