return {
  "airblade/vim-gitgutter",
  cond = function()
    -- Check if CWD or any of its parents have a ".git" dir
    local git_dir = vim.fn.finddir('.git', vim.fn.getcwd() .. ";")
    return git_dir ~= ""
  end,
  config = function()
    vim.g.gitgutter_max_signs = 9999
  end
}
