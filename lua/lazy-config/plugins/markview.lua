return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    opts = {
      preview = {
        enable = true,
        filetypes = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
        ignore_buftypes = { "nofile" },
        ignore_previews = {},
      },
      html = {
        enable = true,
      },
      latex = {
        enable = true,
      },
      typst = {
        enable = true,
      },
      yaml = {
        enable = true,
      },
    },
  },
}
