return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      list = {
        -- This must be a table. Setting preselect to false stops
        -- the "auto-hijack" when you press Enter.
        selection = { preselect = false, auto_insert = false },
      },
    },
    keymap = {
      preset = "default",
      -- This makes Enter behave like a normal newline
      -- unless you have manually highlighted a suggestion.
      ["<CR>"] = { "accept", "fallback" },
    },
  },
}
