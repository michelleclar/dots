local M = {}
local lsp_config = require("plugins.lsp.config")
local utils = require("util")
local autocmds = require("autocommands")

local skipped_servers = lsp_config.automatic_configuration.skipped_servers

local skipped_filetypes = lsp_config.automatic_configuration.skipped_filetypes
local Log = require "log"

local function add_lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

  for mode_name, mode_char in pairs(mappings) do
    for key, remap in pairs(lsp_config.buffer_mappings[mode_name]) do
      local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
      vim.keymap.set(mode_char, key, remap[1], opts)
    end
  end
end

local function add_lsp_buffer_options(bufnr)
  for k, v in pairs(lsp_config.buffer_options) do
    vim.api.nvim_buf_set_option(bufnr, k, v)
  end
end

function M.common_on_attach(client, bufnr)
  if lsp_config.on_attach_callback then
    lsp_config.on_attach_callback(client, bufnr)
    Log:debug "Called lsp.on_attach_callback"
  end
  local lu = require "plugins.lsp.utils"
  if lsp_config.document_highlight then
    lu.setup_document_highlight(client, bufnr)
  end
  if lsp_config.code_lens_refresh then
    lu.setup_codelens_refresh(client, bufnr)
  end
  add_lsp_buffer_keybindings(bufnr)
  add_lsp_buffer_options(bufnr)
  lu.setup_document_symbols(client, bufnr)
end

function M.common_on_init(client, bufnr)
  if lsp_config.on_init_callback then
    lsp_config.on_init_callback(client, bufnr)
    Log:debug "Called lsp.on_init_callback"
    return
  end
end

function M.common_on_exit(_, _)
  if lsp_config.document_highlight then
    autocmds.clear_augroup "lsp_document_highlight"
  end
  if lsp_config.lsp.code_lens_refresh then
    autocmds.clear_augroup "lsp_code_lens_refresh"
  end
end

function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

---Get supported filetypes per server
---@param server_name string can be any server supported by nvim-lsp-installer
---@return string[] supported filestypes as a list of strings
function M.get_supported_filetypes(server_name)
  local status_ok, config = pcall(require, ("lspconfig.server_configurations.%s"):format(server_name))
  if not status_ok then
    return {}
  end

  return config.default_config.filetypes or {}
end

---Get supported servers per filetype
---@param filter { filetype: string | string[] }?: (optional) Used to filter the list of server names.
---@return string[] list of names of supported servers
function M.get_supported_servers(filter)
  -- force synchronous mode, see: |mason-registry.refresh()|
  require("mason-registry").refresh()
  require("mason-registry").get_all_packages()

  local _, supported_servers = pcall(function()
    return require("mason-lspconfig").get_available_servers(filter)
  end)
  return supported_servers or {}
end

function M.remove_template_files()
  -- remove any outdated files
  for _, file in ipairs(vim.fn.glob(lsp_config.templates_dir .. "/*.lua", 1, 1)) do
    vim.fn.delete(file)
  end
end

---Check if we should skip generating an ftplugin file based on the server_name
---@param server_name string name of a valid language server
local function should_skip(server_name)
  return vim.tbl_contains(skipped_servers, server_name)
end

---Generates an ftplugin file based on the server_name in the selected directory
---@param server_name string name of a valid language server, e.g. pyright, gopls, tsserver, etc.
---@param dir string the full path to the desired directory
function M.generate_ftplugin(server_name, dir)
  utils.write_file("/home/carl/.lsp.log", server_name.. "\n", "a")
  if should_skip(server_name) then
    return
  end

  -- get the supported filetypes and remove any ignored ones
  local filetypes = vim.tbl_filter(function(ft)
    return not vim.tbl_contains(skipped_filetypes, ft)
  end, M.get_supported_filetypes(server_name) or {})

  if not filetypes then
    return
  end

  for _, filetype in ipairs(filetypes) do
    filetype = filetype:match "%.([^.]*)$" or filetype
    local filename = utils.join_paths(dir, filetype .. ".lua")
    local setup_cmd = string.format([[require("plugins.lsp.manager").setup(%q)]], server_name)
    require("util").writeFile(nil, setup_cmd .. "\n")
    -- NOTE: overwrite the file completely
    utils.write_file(filename, setup_cmd .. "\n", "a")
  end
end

function M.generate_templates(servers_names)
  servers_names = servers_names or M.get_supported_servers()

  Log:debug "Templates installation in progress"

  M.remove_template_files()

  -- create the directory if it didn't exist
  if not utils.is_directory(lsp_config.templates_dir) then
    vim.fn.mkdir(lsp_config.templates_dir, "p")
  end

  for _, server in ipairs(servers_names) do
    M.generate_ftplugin(server, lsp_config.templates_dir)
  end
  Log:debug "Templates installation is complete"
end

function M.setup()
  Log:debug "Setting up LSP support"

  local lsp_status_ok, _ = pcall(require, "lspconfig")
  if not lsp_status_ok then
    return
  end
  -- NOTE: icon
  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end
  -- NOTE: first open nvim ,generate lsp templates,templates(Mason lsp list)(path:~/.local/share/nvim)
  if not utils.is_directory(lsp_config.templates_dir) then
    M.generate_templates()
  end
  -- NOTE: json config lsp
  pcall(function()
    require("nlspsettings").setup(lsp_config.nlsp_settings.setup)
  end)
  -- NOTE: this remove lazy
  -- require("plugins.lsp.null-ls").setup()

  autocmds.configure_format_on_save()

  local function set_handler_opts_if_not_set(name, handler, opts)
    if debug.getinfo(vim.lsp.handlers[name], "S").source:find(vim.env.VIMRUNTIME, 1, true) then
      vim.lsp.handlers[name] = vim.lsp.with(handler, opts)
    end
  end

  set_handler_opts_if_not_set("textDocument/hover", vim.lsp.handlers.hover, { border = "rounded" })
  set_handler_opts_if_not_set("textDocument/signatureHelp", vim.lsp.handlers.signature_help, { border = "rounded" })

  -- NOTE: Enable rounded borders in :LspInfo window.
  require("lspconfig.ui.windows").default_options.border = "rounded"
end

return M
