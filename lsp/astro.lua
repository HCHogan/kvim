---@brief
---
--- https://github.com/withastro/language-tools/tree/main/packages/language-server
---
--- `astro-ls` can be installed via `npm`:
--- ```sh
--- npm install -g @astrojs/language-server
--- ```

return {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  init_options = {
    typescript = {},
  },
  before_init = function(params, config)
    if vim.tbl_get(config.init_options, "typescript") and not config.init_options.typescript.tsdk then
      local project_root =
          vim.fs.dirname(vim.fs.find("node_modules", { path = params.rootPath, upward = true })[1])
      config.init_options.typescript.tsdk = project_root and (project_root .. "/node_modules/typescript/lib")
          or ""
    end
  end,
}
