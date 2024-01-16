local M = {}
M.set_lsp_keymap = function()
  -- Global mappings.

  -- See `:help vim.diagnostic.*` for documentation on any of the below functions

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
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)         -- cursor in a floating window. Calling the function twice will jump into the floating window
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts) --  (fix) Lists all the implementations for the symbol under the cursor in the quickfix window.
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
      end, opts)                                                      --i don't know it exist meaning
      vim.keymap.set('n', '<C-b>', vim.lsp.buf.type_definition, opts) -- Jumps to the definition of the type of the symbol under the cursor
      vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)             -- rename file
      vim.keymap.set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action, opts) -- show all maybe current line action
      vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opts) -- Lists all the references to the symbol under the cursor in the quickfix window
      vim.keymap.set('n', '<leader>lf', function()
        vim.lsp.buf.format { async = true }
      end, opts)                                                 -- format code
      vim.keymap.set('n', 'gl', vim.diagnostic.open_float)       -- code diagnostic
      vim.keymap.set('n', '<leader>lk', vim.diagnostic.goto_prev) -- prev err
      vim.keymap.set('n', '<leader>lj', vim.diagnostic.goto_next) -- next err
      vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist) -- unkonw

      -- opts
      vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
      vim.keymap.set("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
    end,
  })
end
return M
