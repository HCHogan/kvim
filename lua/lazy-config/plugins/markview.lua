return {
  {
    "OXY2DEV/markview.nvim",
    lazy = true,
    ft = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante", "codecompanion" },
    opts = {
      preview = {
        enable = true,
        filetypes = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante", "codecompanion" },
        ignore_buftypes = { "nofile" },
        ignore_previews = {},
        condition = function(buffer)
          local ft, bt = vim.bo[buffer].ft, vim.bo[buffer].bt;

          if bt == "nofile" and ft == "codecompanion" then
            return true;
          elseif bt == "nofile" then
            return false;
          else
            return true;
          end
        end,
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
