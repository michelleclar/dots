local M = {}
M.config = function()
  local servers = {
    -- "lua_ls",
    -- "cssls",
    -- "html",
    -- "tsserver",
    "pyright",
    -- "bashls",
    "jsonls",
    "marksman",
    "jdtls",
    -- "yamlls",
  }

  local settings = {
    ui = {
      border = "none",
      icons = {
        package_installed = "◍",
        package_pending = "◍",
        package_uninstalled = "◍",
      },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
    keymaps = {
      ---@since 1.0.0
      -- Keymap to expand a package
      toggle_package_expand = "<CR>",
      ---@since 1.0.0
      -- Keymap to install the package under the current cursor position
      install_package = "i",
      ---@since 1.0.0
      -- Keymap to reinstall/update the package under the current cursor position
      update_package = "u",
      ---@since 1.0.0
      -- Keymap to check for new version for the package under the current cursor position
      check_package_version = "c",
      ---@since 1.0.0
      -- Keymap to update all installed packages
      update_all_packages = "U",
      ---@since 1.0.0
      -- Keymap to check which installed packages are outdated
      check_outdated_packages = "C",
      ---@since 1.0.0
      -- Keymap to uninstall a package
      uninstall_package = "X",
      ---@since 1.0.0
      -- Keymap to cancel a package installation
      cancel_installation = "<C-c>",
      ---@since 1.0.0
      -- Keymap to apply language filter
      apply_language_filter = "<C-f>",
      ---@since 1.1.0
      -- Keymap to toggle viewing package installation log
      toggle_package_install_log = "<CR>",
      ---@since 1.8.0
      -- Keymap to toggle the help view
      toggle_help = "g?",
    },
  }

  require("mason").setup(settings)
  require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
  })

  local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_status_ok then
    return
  end

  local opts = {}

  for _, server in pairs(servers) do
    opts = {
      -- on_attach = require("lsp.handlers").on_attach,

      -- on_attach = function(client, bufnr)
      --   if client.server_capabilities.documentSymbolProvider then
      --     navic.attach(client, bufnr)
      --   end
      -- end,
      capabilities = require("plugins.lsp.handlers").capabilities,
    }

    local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
  end
end
return M
