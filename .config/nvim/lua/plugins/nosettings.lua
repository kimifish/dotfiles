return {
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",
  { "nvim-neotest/nvim-nio" }, -- A library for asynchronous IO in Neovim, inspired by the asyncio library in Python

  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim", opts = {} },

  -- { "gsuuon/model.nvim", enabled = false },
}
