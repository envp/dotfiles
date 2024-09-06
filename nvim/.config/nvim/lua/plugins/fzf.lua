return {
  {
    'junegunn/fzf.vim',
    build = ":call fzf#install()",
    dependencies = { "junegunn/fzf" },
    keys = {
      { "<C-o>", vim.cmd.Files, desc = "Browse all files in current dir", },
      { "<C-p>", vim.cmd.GFiles, desc = "Browse all files in current git repo", },
      { "<leader>bl", vim.cmd.Buffers, desc = "Browse open buffers", },
    }
  }
}
