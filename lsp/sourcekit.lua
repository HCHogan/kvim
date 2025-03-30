return {
  cmd = { 'sourcekit-lsp' },
  filetypes = { 'swift' },
  root_markers = { 'buildServer.json', '*.xcodeproj', '*.xcodeworkspace', 'compile_commands.json', 'Package.swift', '.git' },
  single_file_support = true,
  capabilities = {
    offsetEncoding = 'utf-8',
    textDocument = {
      diagnostic = {
        dynamicRegistration = true,
        relatedDocumentSupport = true,
      },
    },
  },
}
