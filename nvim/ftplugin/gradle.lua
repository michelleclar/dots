local opts = {
  root_dir = function(fname)
    local util = require "lspconfig.util"
    local root_files = {
      "settings.gradle", "build.gradle",
    }
    return util.root_pattern(unpack(root_files))(fname) or util.root_pattern ".git" (fname) or util.path.dirname(fname)
  end,
  settings = {
    gradleWrapperEnabled = true,
  },
  filetypes = { "groovy" }
}

require("plugins.lsp.manager").setup("gradle_ls", opts)
