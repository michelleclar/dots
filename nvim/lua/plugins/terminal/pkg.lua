local M = {}

M.plugins_list = {

{
    "akinsho/toggleterm.nvim",
    branch = "main",
    cmd = {
      "ToggleTerm",
      "TermExec",
      "ToggleTermToggleAll",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
    },
  },
}
return M
