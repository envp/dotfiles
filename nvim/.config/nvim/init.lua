-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- NOTE: Load vim options before configuring lazy.nvim
require("options").setup({ background = "dark" })

-- Setup plugin agnostic keymaps
require("keymaps").setup()

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "rebelot/kanagawa.nvim",
      lazy = false,
      priority = 1000,
      opts = {
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
      },
      theme = "dragon",
      init = function ()
        vim.cmd.colorscheme("kanagawa")
      end
    },
    { import = "plugins" },
  },
  rocks = { enabled = false },
  change_detection = { notify = false },
  -- automatically check for plugin updates
  checker = {
    -- Updated manually
    enabled = false,
  },
  -- Use unicode symbols instead of icons.
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      favorite = "꙰꙰⭐",
      ft = "📂",
      import = "📥",
      init = "⚙",
      keys = "🗝",
      lazy = "💤 ",
      plugin = "🔌",
      require = "🚚",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
    },
  },
  colorscheme = { "default" },
})
