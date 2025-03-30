return {
  cmd = { 'sourcekit-lsp' },
  filetypes = { 'swift' },
  root_markers = { 'buildServer.json', '*.xcodeproj', '*.xcodeworkspace', 'compile_commands.json', 'Package.swift', '.git' },
  single_file_support = true,
  capabilities = {
    textDocument = {
      diagnostic = {
        dynamicRegistration = true,
        relatedDocumentSupport = true,
      },
    },
  },
}
