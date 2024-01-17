local M = {}
local Log = require("log")
local tbl = require("util.table")

function M.is_client_active(name)
  local clients = vim.lsp.get_active_clients()
  return tbl.find_first(clients, function(client)
    return client.name == name
  end)
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

function M.setup_document_symbols(client, bufnr)
  vim.g.navic_silence = false -- can be set to true to suppress error
  local symbols_supported = client.supports_method "textDocument/documentSymbol"
  if not symbols_supported then
    Log:debug("skipping setup for document_symbols, method not supported by " .. client.name)
    return
  end
  local status_ok, navic = pcall(require, "nvim-navic")
  if status_ok then
    navic.attach(client, bufnr)
  end
end

function M.setup_document_highlight(client, bufnr)
  -- NOTE: if illuminate is enable
  -- if lvim.builtin.illuminate.active then
    Log:debug "skipping setup for document_highlight, illuminate already active"
    return
  -- end
  -- NOTE: hl
  -- local status_ok, highlight_supported = pcall(function()
  --   return client.supports_method "textDocument/documentHighlight"
  -- end)
  -- if not status_ok or not highlight_supported then
  --   return
  -- end
  -- local group = "lsp_document_highlight"
  -- local hl_events = { "CursorHold", "CursorHoldI" }
  --
  -- local ok, hl_autocmds = pcall(vim.api.nvim_get_autocmds, {
  --   group = group,
  --   buffer = bufnr,
  --   event = hl_events,
  -- })
  --
  -- if ok and #hl_autocmds > 0 then
  --   return
  -- end
  --
  -- vim.api.nvim_create_augroup(group, { clear = false })
  -- vim.api.nvim_create_autocmd(hl_events, {
  --   group = group,
  --   buffer = bufnr,
  --   callback = vim.lsp.buf.document_highlight,
  -- })
  -- vim.api.nvim_create_autocmd("CursorMoved", {
  --   group = group,
  --   buffer = bufnr,
  --   callback = vim.lsp.buf.clear_references,
  -- })
end

return M
