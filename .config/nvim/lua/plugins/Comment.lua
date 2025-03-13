return {
  { 'numToStr/Comment.nvim',
    opts = {},
    config = function()
        -- Comment.nvim mappings and settings
        require('Comment').setup({
          padding = true,
          sticky = true,
          ignore = '^$',
          toggler = {
              line = '<leader>cc',
              block = '<leader>cb',
          },
          opleader = {
              line = '<leader>c',
              block = '<leader>b',
          },
          extra = {
              above = '<leader>cO',
              below = '<leader>co',
              eol = '<leader>ca'
          },
            mappings = { basic = true, extra = true },
          pre_hook = nil,
          post_hook = nil,
        })
            end,
    }
}
