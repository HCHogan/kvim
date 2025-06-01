return {
  "mistricky/codesnap.nvim",
  build = "make",
  event = "VeryLazy",
  opts = {
    save_path = "~/Pictures",
    bg_theme = "bamboo",
    bg_x_padding = 20,
    bg_y_padding = 20,
    code_font_family = "Recursive",
    has_line_number = true,
    watermark = "",
  }
}
