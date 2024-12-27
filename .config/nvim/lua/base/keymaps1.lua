-- Key mappings for which-key
require('which-key').add({
    { "<leader>b", group = "[B]uffer" },
    { "<leader>c", group = "[C]ode" },
    { "<leader>d", group = "[D]ebug" },
    { "<leader>f", group = "[F]ile" },
    { "<leader>g", group = "[G]it" },
    { "<leader>h", group = "Git [H]unk" },
    { "<leader>l", group = "LSP" },
    { "<leader>r", group = "[R]un" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>t", group = "[T]erminal" },
    { "<leader>w", group = "[W]orkspace" },
})

-- Hidden mappings
local hidden_keys = {"<leader>b_", "<leader>c_", "<leader>d_", "<leader>f_", "<leader>g_", "<leader>h_", "<leader>l_", "<leader>r_", "<leader>s_", "<leader>t_", "<leader>w_"}
for _, key in ipairs(hidden_keys) do
    require('which-key').add({ { key, hidden = true } })
end

-- Register visual mode which-key
require('which-key').add({
    { "<leader>", group = "VISUAL <leader>", mode = "v" },
    { "<leader>h", desc = "Git [H]unk", mode = "v" },
}, { mode = 'v' })

-- Key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Exiting insert mode
map("i", "qq", "<esc>", opts)
map("i", "jk", "<esc>", opts)

-- Navigation improvements
map('n', 'H', '_', opts) -- Go to first non-whitespace character
map('n', 'L', '$', opts) -- Go to end of line

-- Better vertical movement
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
vim.o.scrolloff = 8

-- Space key mapped to Nop
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Word wrap navigation
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map('n', '<leader>w', "<C-w>", { desc = '[W]indows'})

-- Telescope key mappings
local telescope = require('telescope.builtin')
map('n', '<leader>?', telescope.oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', telescope.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>s/', function() telescope.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' } end, { desc = '[S]earch [/] in Open Files' })
map('n', '<leader>ss', telescope.builtin, { desc = '[S]earch [S]elect Telescope' })
map('n', '<leader>gf', telescope.git_files, { desc = 'Search [G]it [F]iles' })
map('n', '<leader>sf', telescope.find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>sh', telescope.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sw', telescope.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', telescope.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', telescope.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sr', telescope.resume, { desc = '[S]earch [R]esume' })

map('n', '<leader>/', function()
    telescope.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

-- File browser
map("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)

-- Buffer management with cokeline
local cokeline = require('cokeline.mappings')
map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", opts)
map("n", "<Tab>", "<Plug>(cokeline-focus-next)", opts)
map("n", "<Leader>bp", "<Plug>(cokeline-switch-prev)", { desc = "Switch with [n]ext buffer", silent = true })
map("n", "<Leader>bn", "<Plug>(cokeline-switch-next)", { desc = "Switch with [p]rev buffer", silent = true })
map("n", "<Leader>bd", "<Plug>(cokeline-focus-close)", { desc = "[D]elete buffer", silent = true })
map("n", "<leader>bb", function() cokeline.pick("focus") end, { desc = "Pick a buffer to focus" })

-- Assign buffers to leader-1-0
for i = 1, 9 do
    map("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true, desc = "Focus buffer " .. i })
end

-- Diagnostic key mappings
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Debug mappings
map('n', '<leader>dw', ':set list!<cr>', { desc = "Show [W]hitespace chars" })
map('n', '<leader>dd', require('dapui').toggle, { desc = 'Debug windows' })
map('n', '<leader>dc', require 'dap'.continue, { desc = "[C]ontinue"})
map('n', '<leader>do', require 'dap'.step_over, { desc = "Step [o]ver"})
map('n', '<leader>di', require 'dap'.step_into, { desc = "Step [i]nto"})
map('n', '<leader>du', require 'dap'.step_out, { desc = "Step o[u]t" })
map('n', '<leader>db', require("dap").toggle_breakpoint, { desc = "Breakpoint" })

-- F-key shortcuts for debugging
map('n', '<F5>', require 'dap'.continue)
map('n', '<F10>', require 'dap'.step_over)
map('n', '<F11>', require 'dap'.step_into)
map('n', '<F12>', require 'dap'.step_out)

-- DAP UI signs
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '→', texthl = '', linehl = '', numhl = '' })

-- RunCode mappings
map('n', '<leader>r', ':RunCode<CR>', opts)
map('n', '<leader>rf', ':RunFile<CR>', opts)
map('n', '<leader>rft', ':RunFile tab<CR>', opts)
map('n', '<leader>rp', ':RunProject<CR>', opts)
map('n', '<leader>rc', ':RunClose<CR>', opts)
map('n', '<leader>crf', ':CRFiletype<CR>', opts)
map('n', '<leader>crp', ':CRProjects<CR>', opts)

-- NvimTree open key mapping
map('n', 'ff', ':NvimTreeOpen<CR>', opts)

-- Terminal key mappings
local betterTerm = require('betterTerm')
map("t", "qq", "<c-\\><c-n>")
map({"t"}, "<leader>tk", "<c-\\><c-n><c-w>k", { desc = "Move up from terminal"})
map({"t"}, "<leader>tj", "<c-\\><c-n><c-w>j", { desc = "Move down from terminal"})
map({"n"}, "<leader>tk", "<c-w>ki", { desc = "Move up from terminal"})
map({"n"}, "<leader>tj", "<c-w>ji", { desc = "Move down from terminal"})

map({"n"}, "<leader>tt", betterTerm.select, { desc = "Select terminal"})
map({"n"}, "<leader>`", betterTerm.select, { desc = "Select terminal"})

-- Navigate between panes in tmux
map({"n"}, "<C-h>", ":TmuxNavigateLeft<CR>", opts)
map({"n"}, "<C-l>", ":TmuxNavigateRight<CR>", opts)
map({"n"}, "<C-j>", ":TmuxNavigateDown<CR>", opts)
map({"n"}, "<C-k>", ":TmuxNavigateUp<CR>", opts)

-- Create new term
local current = 2
map({"n"}, "<leader>tn", function()
    betterTerm.open(current)
    current = current + 1
end, { desc = "New terminal" })

require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map({ 'n', 'v' }, ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'Jump to next hunk' })

    map({ 'n', 'v' }, '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'Jump to previous hunk' })

    -- Actions
    -- visual mode
    map('v', '<leader>hs', function()
      gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'stage git hunk' })
    map('v', '<leader>hr', function()
      gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'reset git hunk' })
    -- normal mode
    map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
    map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
    map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
    map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
    map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
    map('n', '<leader>hb', function()
      gs.blame_line { full = false }
    end, { desc = 'git blame line' })
    map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
    map('n', '<leader>hD', function()
      gs.diffthis '~'
    end, { desc = 'git diff against last commit' })

    -- Toggles
    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
    -- map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
  end,
})
