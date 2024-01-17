local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- 启用代码片段支持
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- 启用代码重命名
M.capabilities.textDocument.rename.provider = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
--[[ M.capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' } ]]
--[[ M.capabilities.textDocument.completion.completionItem.snippetSupport = true ]]
--[[ M.capabilities.textDocument.completion.completionItem.preselectSupport = true ]]
--[[ M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true ]]
--[[ M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true ]]
--[[ M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true ]]
--[[ M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true ]]
--[[ M.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } } ]]
--[[ M.capabilities.textDocument.completion.completionItem.resolveSupport = { ]]
--[[ 	properties = { ]]
--[[ 		'documentation', ]]
--[[ 		'detail', ]]
--[[ 		'additionalTextEdits', ]]
--[[ 	}, ]]
--[[ } ]]
M.setup = function()
  local signs = {

    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false, -- disable virtual text
    signs = {
      active = signs,     -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config) --seting float windows

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  }) -- float style is rounded
end

function M.setup_codelens_refresh(client, bufnr)
  local status_ok, codelens_supported = pcall(function()
    return client.supports_method "textDocument/codeLens"
  end)
  if not status_ok or not codelens_supported then
    return
  end
  local group = "lsp_code_lens_refresh"
  local cl_events = { "BufEnter", "InsertLeave" }
  local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = group,
    buffer = bufnr,
    event = cl_events,
  })

  if ok and #cl_autocmds > 0 then
    return
  end
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_create_autocmd(cl_events, {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.codelens.refresh,
  })
end

M.buffer_mappings = {
  normal_mode = {
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition" },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto references" },
    ["gI"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation" },
    ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "show signature help" },
    ["gl"] = {
      function()
        local float = vim.diagnostic.config().float

        if float then
          local config = type(float) == "table" and float or {}
          config.scope = "line"

          vim.diagnostic.open_float(config)
        end
      end,
      "Show line diagnostics",
    },
  },
  insert_mode = {},
  visual_mode = {},
}

M.buffer_options = {
  --- enable completion triggered by <c-x><c-o>
  omnifunc = "v:lua.vim.lsp.omnifunc",
  --- use gq for formatting
  formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:500})",
}

local function add_lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

  for mode_name, mode_char in pairs(mappings) do
    for key, remap in pairs(M.buffer_mappings[mode_name]) do
      local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
      vim.keymap.set(mode_char, key, remap[1], opts)
    end
  end
end

local function add_lsp_buffer_options(bufnr)
  for k, v in pairs(M.buffer_options) do
    vim.api.nvim_buf_set_option(bufnr, k, v)
  end
end

function M.setup_document_symbols(client, bufnr)
  vim.g.navic_silence = false -- can be set to true to suppress error
  local symbols_supported = client.supports_method "textDocument/documentSymbol"
  if not symbols_supported then
    return
  end
  local status_ok, navic = pcall(require, "nvim-navic")
  if status_ok then
    navic.attach(client, bufnr)
  end
end

function M.common_on_attach(client, bufnr)

  M.setup_codelens_refresh(client, bufnr)
  add_lsp_buffer_keybindings(bufnr)
  add_lsp_buffer_options(bufnr)
  M.setup_document_symbols(client, bufnr)
end
function M.common_on_init(client, bufnr)
end
function M.common_on_exit(_, _)
  -- if lvim.lsp.code_lens_refresh then
  --   autocmds.clear_augroup "lsp_code_lens_refresh"
  -- end
end
--[[ local function lsp_keymaps(bufnr) ]]
--[[ 	local opts = { noremap = true, silent = true } ]]
--[[ 	local keymap = vim.api.nvim_buf_set_keymap ]]
--[[ 	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) ]]
--[[ 	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) ]]
--[[ 	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) ]]
--[[ 	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) ]]
--[[ 	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) ]]
--[[ 	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) ]]
--[[ 	keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts) -- 格式化代码 ]]
--[[ 	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts) ]]
--[[ 	keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts) ]]
--[[ 	keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts) ]]
--[[ 	keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts) ]]
--[[ 	keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts) ]]
--[[ 	keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts) ]]
--[[ 	keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) ]]
--[[ 	keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts) ]]
--[[ end ]]
--[[]]
--[[ M.on_attach = function(client, bufnr) ]]
--[[ 	if client.name == "tsserver" then ]]
--[[ 		client.server_capabilities.documentFormattingProvider = false ]]
--[[ 	end ]]
--[[]]
--[[ 	if client.name == "sumneko_lua" then ]]
--[[ 		client.server_capabilities.documentFormattingProvider = false ]]
--[[ 	end ]]
--[[]]
--[[   print('hello ' .. client.name .. 'on ' .. bufnr) ]]
--[[   lsp_keymaps(bufnr) ]]
--[[ end ]]

return M
