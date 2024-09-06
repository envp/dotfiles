EXPORTS = {

  setup = function()
    vim.keymap.set(
      { "n", "v", "o" },
      "<C-l>", vim.cmd.nohlsearch,
      { silent = true, desc = "Clear search highlighting" }
    )
    vim.keymap.set("n", "<leader>be", vim.cmd.enew, { silent = true, desc = "Create a new buffer" })
    vim.keymap.set("n", "<leader>bn", vim.cmd.bnext, { silent = true, desc = "Goto next buffer" })
    vim.keymap.set("n", "<leader>bq", vim.cmd.bdelete, { silent = true, desc = "Discard buffer" })
    vim.keymap.set("n", "<leader>bv", vim.cmd.bprevious, { silent = true, desc = "Goto prev buffer" })

    -- Move around selected lines in Visual mode
    vim.keymap.set("v", "<S-Up>", ":move '<-2<CR>gv=gv")
    vim.keymap.set("v", "<S-Down>", ":move '>+1<CR>gv=gv")
  end
}

return EXPORTS
