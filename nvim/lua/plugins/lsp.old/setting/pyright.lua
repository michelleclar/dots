local opts = {
  cmd = {
    "pyright-langserver",
    "--stdio",
  },
  filetypes = {
    "python",
  },
  setting = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
  single_file_support = true,
}

return opts
