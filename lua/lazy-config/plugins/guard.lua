return {
  "nvimdev/guard.nvim",
  dependencies = {
    "nvimdev/guard-collection",
  },
  event = "BufReadPost",
  opts = {},
  config = function()
    local ft = require("guard.filetype")

    if vim.fn.executable("hlint") == 1 then
      ft("haskell"):lint("hlint")
    end

    if vim.fn.executable("stylua") == 1 then
      ft("lua"):fmt("stylua")
    end

    if vim.fn.executable("clang-tidy") == 1 then
      ft("c"):lint("clang-tidy")
      ft("cpp"):lint("clang-tidy")
    end

    if vim.fn.executable("alejandra") == 1 then
      ft("nix"):fmt("alejandra")
    end

    vim.g.guard_config = {
      fmt_on_save = false,
      save_on_fmt = false,
      lsp_as_default_formatter = true,
    }
  end,
}
