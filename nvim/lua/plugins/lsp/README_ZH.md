### LSP
*    使用 Mason 管理 LSP，使用 None-LS（之前称为 Null-LS）进行代码格式化.
*    使用 nlsp-config 简化 LSP 配置，支持基于 JSON 的服务器设置。使用 LspSettings ${servername} 命令生成服务器专用的配置文件，这些文件位于 Nvim 配置目录下的 lsp-settings 子目录中.

### 增强插件
* 利用 neodev 配置 lua_ls，为 Nvim 配置提供全面的 Vim 和 Neovim API 补全。为此，你可能需要在 Nvim 配置目录中手动创建一个 .luarc.json 文件.
* 使用 vim-illuminate 增强单词可见性和导航功能，该插件会高亮显示当前单词并支持快速跳转到其他相同单词.
* 使用 lsp_signature.nvim 提高代码清晰度和效率，该插件在编辑时提供实时函数参数类型提示.
* 使用 nvim-jdtls 将 Nvim 中的 Java 开发体验提升到类似 Eclipse 的水平，提供舒适的代码补全功能,自动包导入等等.
