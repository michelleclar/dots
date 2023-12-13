local status_ok, comment_box = pcall(require, "comment-box")
if not status_ok then
	return
end
comment_box.setup()
--[[ local keymap = vim.keymap.set ]]
--[[ local cb = require("comment-box") ]]
--[[]]
--[[ -- left aligned fixed size box with left aligned text ]]
--[[ keymap({ "n", "v"}, "<Leader>bb", cb.lbox, {}) ]]
--[[ -- centered adapted box with centered text ]]
--[[ keymap({ "n", "v"}, "<Leader>bc", cb.ccbox, {}) ]]
--[[]]
--[[ -- centered line ]]
--[[ keymap("n", "<Leader>bl", cb.cline, {}) ]]
--[[ keymap("i", "<M-l>", cb.cline, {}) ]]
--         ╭──────────────────────────────────────────────────────────╮
--         │                                                          │
--         ╰──────────────────────────────────────────────────────────╯
--                                      ╭╮
--                                      ││
--                                      ╰╯
--  ▲                                                          ▲
--  █                                                          █
--  ▼                                                          ▼
-- example
--  ╭──────────────────────────────────────────────────────────╮
--  │ A left aligned fixed size box with the text left         │
--  │  justified:                                              │
--  │ :CBllbox                                                 │
--  │ or                                                       │
--  │ :lua require("comment-box").llbox()                      │
--  │                                                          │
--  │ A centered fixed size box with the text centered:        │
--  │ :CBccbox                                                 │
--  │ or                                                       │
--  │ :lua require("comment-box").ccbox()                      │
--  │                                                          │
--  │ A centered adapted box:                                  │
--  │ :CBacbox                                                 │
--  │ or                                                       │
--  │ :lua require("comment-box").acbox()                      │
--  │                                                          │
--  │ A left aligned fixed size box with the text left         │
--  │  justified,                                              │
--  │ using the syle 17 from the catalog:                      │
--  │ :CBllbox17                                               │
--  │ or                                                       │
--  │ :lua require("comment-box").llbox(17)                    │
--  ╰──────────────────────────────────────────────────────────╯
