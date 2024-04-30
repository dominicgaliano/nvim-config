require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "tsserver", "eslint", "svelte", "html" }
})

local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

-- Python
nvim_lsp.pylsp.setup({})

-- TypeScript
nvim_lsp.eslint.setup({})
-- MOVED TO Typescript.lua
--nvim_lsp.tsserver.setup({
---- Needed for inlayHints. Merge this table with your settings or copy
--    -- it from the source if you want to add your own init_options.
--    init_options = require("nvim-lsp-ts-utils").init_options,
--    --
--    on_attach = function(client, bufnr)
--        local ts_utils = require("nvim-lsp-ts-utils")

--        -- defaults
--        ts_utils.setup({
--            debug = false,
--            disable_commands = false,
--            enable_import_on_completion = false,

--            -- import all
--            import_all_timeout = 5000, -- ms
--            -- lower numbers = higher priority
--            import_all_priorities = {
--                same_file = 1, -- add to existing import statement
--                local_files = 2, -- git files or files with relative path markers
--                buffer_content = 3, -- loaded buffer content
--                buffers = 4, -- loaded buffer names
--            },
--            import_all_scan_buffers = 100,
--            import_all_select_source = false,
--            -- if false will avoid organizing imports
--            always_organize_imports = true,

--            -- filter diagnostics
--            filter_out_diagnostics_by_severity = {},
--            filter_out_diagnostics_by_code = {},

--            -- inlay hints
--            auto_inlay_hints = true,
--            inlay_hints_highlight = "Comment",
--            inlay_hints_priority = 200, -- priority of the hint extmarks
--            inlay_hints_throttle = 150, -- throttle the inlay hint request
--            inlay_hints_format = { -- format options for individual hint kind
--                Type = {},
--                Parameter = {},
--                Enum = {},
--                -- Example format customization for `Type` kind:
--                -- Type = {
--                --     highlight = "Comment",
--                --     text = function(text)
--                --         return "->" .. text:sub(2)
--                --     end,
--                -- },
--            },

--            -- update imports on file move
--            update_imports_on_move = false,
--            require_confirmation_on_move = false,
--            watch_dir = nil,
--        })

--        -- required to fix code action ranges and filter diagnostics
--        ts_utils.setup_client(client)

--        -- no default maps, so you may want to define some here
--        local opts = { silent = true }
--        vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
--        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
--        vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
--    end,
--}) 

-- Svelte
nvim_lsp.svelte.setup {
  filetypes = { "svelte" },
  on_attach = function(client, bufnr)
    if client.name == 'svelte' then
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.js", "*.ts" },
        callback = function(ctx)
          client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
        end,
      })
    end
  end
}

-- Yaml
require('lspconfig').yamlls.setup {
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      },
    },
  }
}

-- Go
nvim_lsp.gopls.setup({
  cmd = { "gopls", "serve" },
  on_attach = function(client, bufnr)
    -- Disable formatting with gopls
    -- client.resolved_capabilities.document_formatting = false
  end,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        unreachable = false,
      },
      staticcheck = true, -- Enable staticcheck for diagnostics and quick-fixes
      experimentalPostfixCompletions = true, -- Enable experimental postfix completions
    },
  },
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
