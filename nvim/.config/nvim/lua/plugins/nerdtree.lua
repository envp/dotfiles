return {
  {
    "preservim/nerdtree",
    config = function()
    vim.g.NERDTreeDirArrowExpandable = "+"
    vim.g.NERDTreeDirArrowCollapsible = "~"
    vim.cmd([[
      let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.a$', '\.tsk$', '\.linux$']
    ]])
    end,
    keys = {
      {"<leader>n", function() vim.cmd("NERDTreeToggle") end, desc = "Open NERDTree file browser"}
    },
  },
  {
    "PhilRunninger/nerdtree-buffer-ops",
    cmd = "NERDTreeToggle",
  },
}
