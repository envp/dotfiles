return {
  "luochen1990/rainbow",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.g.rainbow_active = true
    vim.g.rainbow_conf = {
      separately = { cmake = 0 }
    }
  end,
}
