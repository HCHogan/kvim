return {
  cmd = { 'clangd', "--background-index" },
  root_markers = { '.clangd', 'compile_commands.json', '.git', '.clang-tidy', '.clang-format' },
  filetypes = { 'c', 'cpp', 'cuda', 'proto' },
  single_file_support = true,
  capabilities = {
    offsetEncoding = { 'utf-8', 'utf-16' },
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
      semanticTokens = {
        multilineTokenSupport = true,
      },
    }
  },
}
