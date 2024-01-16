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
    -- "jdtls",
    -- "yamlls",
  }
  local opts = {
    ui = {
      check_outdated_packages_on_open = true,
      width = 0.8,
      height = 0.9,
      border = "rounded",
      keymaps = {
        toggle_package_expand = "<CR>",
        install_package = "i",
        update_package = "u",
        check_package_version = "c",
        update_all_packages = "U",
        check_outdated_packages = "C",
        uninstall_package = "X",
        cancel_installation = "<C-c>",
        apply_language_filter = "<C-f>",
      },
    },

    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },

    -- NOTE: should be available in $PATH
    -- install_root_dir = join_paths(vim.fn.stdpath "data", "mason"),

    -- NOTE: already handled in the bootstrap stage
    -- PATH = "skip",

    pip = {
      upgrade_pip = false,
      -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
      -- and is not recommended.
      --
      -- Example: { "--proxy", "https://proxyserver" }
      install_args = {},
    },

    -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
    -- debugging issues with package installations.
    log_level = vim.log.levels.INFO,

    -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
    -- packages that are requested to be installed will be put in a queue.
    max_concurrent_installers = 4,

    -- [Advanced setting]
    -- The registries to source packages from. Accepts multiple entries. Should a package with the same name exist in
    -- multiple registries, the registry listed first will be used.
    registries = {
      "lua:mason-registry.index",
      "github:mason-org/mason-registry",
    },

    -- The provider implementations to use for resolving supplementary package metadata (e.g., all available versions).
    -- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
    providers = {
      "mason.providers.registry-api",
      "mason.providers.client",
    },

    github = {
      -- The template URL to use when downloading assets from GitHub.
      -- The placeholders are the following (in order):
      -- 1. The repository (e.g. "rust-lang/rust-analyzer")
      -- 2. The release version (e.g. "v0.3.0")
      -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
      download_url_template = "https://github.com/%s/releases/download/%s/%s",
    },

    on_config_done = nil,
  }
  require("mason").setup(opts)
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
