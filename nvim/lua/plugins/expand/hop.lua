local M = {}
M.config = function()
  local set_hop_keymaps = function()
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", "s", ":HopChar2MW<cr>", opts)
    vim.api.nvim_set_keymap("n", "S", ":HopWordMW<cr>", opts)
    vim.api.nvim_set_keymap(
      "n",
      "f",
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
      {}
    )
    vim.api.nvim_set_keymap(
      "n",
      "F",
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
      {}
    )
    vim.api.nvim_set_keymap(
      "o",
      "f",
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
      {}
    )
    vim.api.nvim_set_keymap(
      "o",
      "F",
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
      {}
    )
    vim.api.nvim_set_keymap(
      "",
      "t",
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
      {}
    )
    vim.api.nvim_set_keymap(
      "",
      "T",
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
      {}
    )
  end
  local status_ok, hop = pcall(require, "hop")
  if not status_ok then
    return
  end
  local opts = {}
  hop.setup(opts)
  set_hop_keymaps()
end
return M
