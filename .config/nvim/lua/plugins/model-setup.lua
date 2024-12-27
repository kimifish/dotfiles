local proxy_openai = require("model.providers.openai")
local util = require("model.util")

require('model').setup({
    cmd = { 'M', 'Model', 'Mchat' },
    init = function()
      vim.filetype.add({
        extension = {
          mchat = 'mchat',
        }
      })
    end,
    ft = 'mchat',

    keys = {
      {'<C-m>d', ':Mdelete<cr>', mode = 'n'},
      {'<C-m>s', ':Mselect<cr>', mode = 'n'},
      {'<C-m><space>', ':Mchat<cr>', mode = 'n' }
    },
    hl_group = "Substitute",
    chats = { hella = "You are helpful assistant." },
    prompts = util.module.autoload("prompt_library"),
    default_prompt = {
        provider = proxy_openai,
        options = {
            url = "https://api.proxyapi.ru/openai/v1",
            authorization = "Bearer sk-Qi8EhxRNsnDfHN6jfVpprNaM58yp0d60",
        },
        builder = function(input)
            return {
                model = "gpt-4o-mini",
                temperature = 0.3,
                max_tokens = 400,
                messages = {
                    {
                        role = "system",
                        content = "You are helpful assistant.",
                    },
                    { role = "user", content = input },
                },
            }
        end,
    },
    -- To override defaults add a config field and call setup()

    -- config = function()
    --   require('model').setup({
    --     prompts = {..},
    --     chats = {..},
    --     ..
    --   })

    --   require('model.providers.llamacpp').setup({
    --     binary = '~/path/to/server/binary',
    --     models = '~/path/to/models/directory'
    --   })
    -- end
})
