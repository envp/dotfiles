function CreateStatusline()
  local ts_statusline = vim.fn["nvim_treesitter#statusline"]()
  if ts_statusline == vim.NIL then
    return ""
  end
  return ts_statusline
end

local lualine_opts = {
  options = {
    theme = "dayfox",
    icons_enabled = false,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      {
        "CreateStatusline()",
        color = "DiagnosticVirtualTextInfo",
        separator = { right = "" },
      },
    },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location", "searchcount" },
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
        show_filename_only = false,
        mode = 4,
        use_mode_colors = true,
        symbols = {
          modified = " ●", -- Text to show when the buffer is modified
          alternate_file = "# ", -- Text to show to identify the alternate file
          directory = "[D]", -- Text to show when the buffer is a directory
        },
        max_length = vim.o.columns * 2 / 3
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {
        "tabs",
        mode = 2,
      },
    },
  },
  extensions = {
    "nerdtree",
    "fugitive",
  },
}

return {
  {
    -- This is required for the lualine theme
    "EdenEast/nightfox.nvim",
    event = "VeryLazy",
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = lualine_opts,
    event = "VeryLazy",
    init = function()
      require("nightfox").setup()
    end
  },
}
