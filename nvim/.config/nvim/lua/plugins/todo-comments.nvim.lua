return {
  "folke/todo-comments.nvim",
  priority = 0,
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
}
