return {
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")
      local cmp = require("cmp")
      local types = require("cmp.types")

      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({})
      --
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete({}),
          -- ["<CR>"] = cmp.mapping.confirm({
          --   behavior = cmp.ConfirmBehavior.Replace,
          -- select = true,
          -- }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          -- { name = 'codecompanion' },
          {
            name = "dotenv",
            option = {
              path = ".",
              load_shell = true,
              item_kind = cmp.lsp.CompletionItemKind.Variable,
              eval_on_confirm = false,
              show_documentation = true,
              show_content_on_docs = true,
              documentation_kind = "markdown",
              dotenv_environment = ".*",
              file_priority = function(a, b)
                -- Prioritizing local files
                return a:upper() < b:upper()
              end,
            },
          },
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            -- function(entry1, entry2)
            --     local kind1 = entry1:get_kind()
            --     -- kind1 = kind1 == types.lsp.CompletionItemKind.Supermaven and 110 or kind1
            --     kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
            --     local kind2 = entry2:get_kind()
            --     kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
            --     if kind1 ~= kind2 then
            --         if kind1 == types.lsp.CompletionItemKind.Supermaven then
            --             return true
            --         end
            --         if kind2 == types.lsp.CompletionItemKind.Supermaven then
            --             return false
            --         end
            --         if kind1 == types.lsp.CompletionItemKind.Snippet then
            --             return false
            --         end
            --         if kind2 == types.lsp.CompletionItemKind.Snippet then
            --             return true
            --         end
            --         local diff = kind1 - kind2
            --         if diff < 0 then
            --             return false
            --         elseif diff > 0 then
            --             return true
            --         end
            --     end
            -- end,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
