-- lualine.nvim
function CreateStatusline()
  local ts_statusline = vim.fn["nvim_treesitter#statusline"]()
  if ts_statusline == vim.NIL then
    return ""
  end
  return ts_statusline
end

local function term_can_render_separators()
  return vim.env.TERM ~= "alacritty"
end

local function try_use_separators(seps)
  if term_can_render_separators() then
    return seps
  end
  return { left = "", right = "" }
end

require("lualine").setup({
  options = {
    theme = 'auto',
    icons_enabled = false,
    component_separators = try_use_separators({ left = "", right = "" }),
    section_separators = try_use_separators({ left = "", right = "" }),
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      {
        "CreateStatusline()",
        color = "DiagnosticVirtualTextInfo",
        separator = try_use_separators({ right = "" }),
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
})
