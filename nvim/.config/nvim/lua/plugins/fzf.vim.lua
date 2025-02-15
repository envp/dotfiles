return {
  {
    'junegunn/fzf.vim',
    enable = false,
    build = ":call fzf#install()",
    dependencies = { "junegunn/fzf" },
    keys = {
      { "<C-o>", vim.cmd.Files, desc = "Browse all files in current dir", },
      { "<C-p>", vim.cmd.GFiles, desc = "Browse all files in current git repo", },
      { "<C-b>", vim.cmd.Buffers, desc = "Browse open buffers", },
    }
  }
}
