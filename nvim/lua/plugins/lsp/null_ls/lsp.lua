local M = {}

local buffer_mappings = {
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


local function add_lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

  for mode_name, mode_char in pairs(mappings) do
    for key, remap in pairs(buffer_mappings[mode_name]) do
      local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
      vim.keymap.set(mode_char, key, remap[1], opts)
    end
  end
end

local function setup_document_symbols(client, bufnr)
  vim.g.navic_silence = false -- can be set to true to suppress error
  local symbols_supported = client.supports_method "textDocument/documentSymbol"
  if not symbols_supported then
    vim.notify("skipping setup for document_symbols, method not supported by " .. client.name)
    return
  end
  local status_ok, navic = pcall(require, "nvim-navic")
  if status_ok then
    navic.attach(client, bufnr)
  end
end

local function setup_codelens_refresh(client, bufnr)
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



local buffer_options = {
  --- enable completion triggered by <c-x><c-o>
  omnifunc = "v:lua.vim.lsp.omnifunc",
  --- use gq for formatting
  formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:500})",
}

local function add_lsp_buffer_options(bufnr)
  for k, v in pairs(buffer_options) do
    vim.api.nvim_buf_set_option(bufnr, k, v)
  end
end


function M.common_on_attach(client, bufnr)
  setup_codelens_refresh(client, bufnr)
  add_lsp_buffer_keybindings(bufnr)
  add_lsp_buffer_options(bufnr)
  setup_document_symbols(client, bufnr)
end

return M
