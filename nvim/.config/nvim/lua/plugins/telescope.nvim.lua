local function curried_telescope_wrapper(cmd)
  return function()
    vim.cmd.Telescope(cmd)
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    opts = function ()
      local telescopeConfig = require("telescope.config")
      local actions = require("telescope.actions")

      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      -- Minor tweaks to ripgrep:
      -- * Search in hidden paths, except .git/
      table.insert(vimgrep_arguments, "--hidden")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")
      return {
        defaults = {
          vimgrep_arguments = vimgrep_arguments,
          mappings = {
            -- Make it so that a SINGLE ESC is enough to quit telescope UI.
            i = { ["<esc>"] = actions.close, }
          }
        },
        pickers = {
          find_files = {
            -- Show hidden files, but not inside any .git/
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
          },
        }
      }
    end,
    keys = {
      { "<C-o>", curried_telescope_wrapper("find_files"), desc = "[o]pen file in current dir", },
      { "<C-p>", curried_telescope_wrapper("live_grep"),  desc = "[p]attern search in current dir", },
      { "<C-b>", curried_telescope_wrapper("buffers"),    desc = "Browse [b]uffers", },
    }
  }
}
