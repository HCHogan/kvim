return {
  "mistricky/codesnap.nvim",
  build = "make",
  event = "VeryLazy",
  opts = {
    save_path = "~/Pictures",
    bg_theme = "sea",
    code_font_family = "RecMonoLinear Nerd Font Mono",
    has_line_number = true,
    watermark = "",
  }
}
