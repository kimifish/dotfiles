-- Key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local snacks = require('snacks')
local telescope = require('telescope.builtin')
local cokeline = require('cokeline.mappings')
local avante_prompts = require('base.avante_prompts')

-- Key mappings for which-key
require('which-key').add({
    { "<leader>b", group = "Buffer" },
    { "<leader>c", group = "Code" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "File" },
    { "<leader>g", group = "Git" },
    { "<leader>h", group = "Git Hunk" },
    { "<leader>l", group = "LSP" },
    { "<leader>r", group = "Run" },
    { "<leader>s", group = "Search" },
    { "<leader>t", group = "Terminal" },
    { "<leader>w", group = "Workspace" },
    { "<leader>q", group = "Diagnostics" },
})

-- Hidden mappings
local hidden_keys = {"<leader>b_", "<leader>c_", "<leader>d_", "<leader>f_", "<leader>g_", "<leader>h_", "<leader>l_", "<leader>r_", "<leader>s_", "<leader>t_", "<leader>w_"}
for _, key in ipairs(hidden_keys) do
    require('which-key').add({ { key, hidden = true } })
end

require('which-key').add {
  { '<leader>a', group = 'Avante' }, -- NOTE: add for avante.nvim
  {
    mode = { 'n', 'v' },
    { '<leader>ag', function() require('avante.api').ask { question = avante_prompts.grammar_correction } end, desc = 'Grammar Correction(ask)' },
    { '<leader>ak', function() require('avante.api').ask { question = avante_prompts.keywords } end, desc = 'Keywords(ask)' },
    { '<leader>al', function() require('avante.api').ask { question = avante_prompts.code_readability_analysis } end, desc = 'Code Readability Analysis(ask)' },
    { '<leader>ao', function() require('avante.api').ask { question = avante_prompts.optimize_code } end, desc = 'Optimize Code(ask)' },
    { '<leader>am', function() require('avante.api').ask { question = avante_prompts.summarize } end, desc = 'Summarize text(ask)' },
    { '<leader>an', function() require('avante.api').ask { question = avante_prompts.translate } end, desc = 'Translate text(ask)' },
    { '<leader>ax', function() require('avante.api').ask { question = avante_prompts.explain_code } end, desc = 'Explain Code(ask)' },
    { '<leader>ac', function() require('avante.api').ask { question = avante_prompts.complete_code } end, desc = 'Complete Code(ask)' },
    { '<leader>ad', function() require('avante.api').ask { question = avante_prompts.add_docstring } end, desc = 'Docstring(ask)' },
    { '<leader>ab', function() require('avante.api').ask { question = avante_prompts.fix_bugs } end, desc = 'Fix Bugs(ask)' },
    { '<leader>au', function() require('avante.api').ask { question = avante_prompts.add_tests } end, desc = 'Add Tests(ask)' },
  },
}

require('which-key').add {
  { '<leader>a', group = 'Avante' }, -- NOTE: add for avante.nvim
  {
    mode = { 'v' },
    { '<leader>aG', function() avante_prompts.prefill_edit_window(avante_prompts.grammar_correction) end, desc = 'Grammar Correction' },
    { '<leader>aK', function() avante_prompts.prefill_edit_window(avante_prompts.keywords) end, desc = 'Keywords' },
    { '<leader>aO', function() avante_prompts.prefill_edit_window(avante_prompts.optimize_code) end, desc = 'Optimize Code(edit)' },
    { '<leader>aC', function() avante_prompts.prefill_edit_window(avante_prompts.complete_code) end, desc = 'Complete Code(edit)' },
    { '<leader>aD', function() avante_prompts.prefill_edit_window(avante_prompts.add_docstring) end, desc = 'Docstring(edit)' },
    { '<leader>aB', function() avante_prompts.prefill_edit_window(avante_prompts.fix_bugs) end, desc = 'Fix Bugs(edit)' },
    { '<leader>aU', function() avante_prompts.prefill_edit_window(avante_prompts.add_tests) end, desc = 'Add Tests(edit)' },
    { '<leader>aT', function() avante_prompts.prefill_edit_window(avante_prompts.translate_comments_to_en) end, desc = 'Translate comments to En' },
  },
}

-- Register visual mode which-key
require('which-key').add({
    { "<leader>", group = "VISUAL <leader>", mode = "v" },
    { "<leader>h", desc = "Git [H]unk", mode = "v" },
}, { mode = 'v' })

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

map('n', '<leader>w', "<C-w>" )

-- Git
map('n', '<leader>gg', function () snacks.lazygit() end, { desc = "LazyGit" })
map('n', '<leader>gl', function () snacks.lazygit.log() end, { desc = "LazyGit log (cwd)" })
map('n', '<leader>gf', function () snacks.lazygit.log_file() end, { desc = "LazyGit current file history" })
map('n', '<leader>gs', function () snacks.picker.git_files() end, { desc = 'Search Git files' })

-- Search key mappings
map('n', '<leader>sr', function () snacks.picker.registers() end, { desc = '[ ] Find registers' })
map('n', '<leader>sh', function () snacks.picker.help() end, { desc = 'Search Help' })
map('n', '<leader>s/', function () snacks.picker.grep_buffers() end, { desc = 'Search / in Open Files' })
map('n', '<leader>sg', function () snacks.picker.grep() end, { desc = 'Search by Grep' })
map('n', '<leader>sw', function () snacks.picker.grep_word() end, { desc = 'Search current Word' })
map('n', "<leader>sh", function () snacks.picker.help() end, { desc = "Help Pages" })
map('n', "<leader>sH", function () snacks.picker.highlights() end, { desc = "Highlights" })
map('n', "<leader>sj", function () snacks.picker.jumps() end, { desc = "Jumps" })
map('n', "<leader>sk", function () snacks.picker.keymaps() end, { desc = "Keymaps" })
map('n', "<leader>sl", function () snacks.picker.loclist() end, { desc = "Location List" })
map('n', "<leader>sM", function () snacks.picker.man() end, { desc = "Man Pages" })
map('n', "<leader>sm", function () snacks.picker.marks() end, { desc = "Marks" })
map('n', "<leader>sR", function () snacks.picker.resume() end, { desc = "Resume" })
map('n', "<leader>sq", function () snacks.picker.qflist() end, { desc = "Quickfix List" })
map('n', "<leader>uC", function () snacks.picker.colorschemes() end, { desc = "Colorschemes" })
map('n', "<leader>qp", function () snacks.picker.projects() end, { desc = "Projects" })
-- map('n', '<leader>?', telescope.oldfiles, { desc = '[?] Find recently opened files' })
-- map('n', '<leader><space>', telescope.buffers, { desc = '[ ] Find existing buffers' })
-- map('n', '<leader>sw', telescope.grep_string, { desc = '[S]earch current [W]ord' })
-- map('n', '<leader>sg', telescope.live_grep, { desc = '[S]earch by [G]rep' })
-- map('n', '<leader>sf', telescope.find_files, { desc = '[S]earch [F]iles' })
-- map('n', '<leader>sd', telescope.diagnostics, { desc = '[S]earch [D]iagnostics' })
-- map('n', '<leader>sr', telescope.resume, { desc = '[S]earch [R]esume' })
-- map('n', '<leader>ss', telescope.builtin, { desc = '[S]earch [S]elect Telescope' })

map('n', '<leader>/', function()
    telescope.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

-- File browser
-- map("n", "<space>fb", ":Telescope file browser path=%:p:h select_buffer=true<CR>", {desc = "Pick file" })
map('n', '<leader>ff', function () snacks.picker.files() end, { desc = 'Find files' })
map('n', '<leader>fF', function () snacks.picker.recent() end, { desc = '[?] Find recently opened files' })
map('n', '<leader>fc', function () snacks.picker.files( {cwd = vim.fn.stdpath("config") } ) end, { desc = 'Find config files' })
map('n', '<leader>fb', function () snacks.picker.files( {cwd = "~/bin/" } ) end, { desc = 'Find files in ~/bin' })
map('n', '<leader>fr', function () snacks.rename.rename_file() end, { desc = "Rename file" })

-- Buffer management with cokeline
map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", opts)
map("n", "<Tab>", "<Plug>(cokeline-focus-next)", opts)
map('n', '<leader><space>', function () snacks.picker.buffers() end, { desc = '[ ] Find existing buffers' })
map("n", "<Leader>bp", "<Plug>(cokeline-switch-prev)", { desc = "Switch with [n]ext buffer", silent = true })
map("n", "<Leader>bn", "<Plug>(cokeline-switch-next)", { desc = "Switch with [p]rev buffer", silent = true })
-- map("n", "<Leader>bd", "<Plug>(cokeline-focus-close)", { desc = "[D]elete buffer", silent = true })
map("n", "<Leader>bd", function () snacks.bufdelete() end, { desc = "[D]elete buffer", silent = true })
map("n", "<leader>bb", function() cokeline.pick("focus") end, { desc = "Pick a buffer to focus" })

-- Assign buffers to leader-1-0
for i = 1, 9 do
    map("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true, desc = "Focus buffer " .. i })
end

    -- LSP
map('n', "gd", function() snacks.picker.lsp_definitions() end, {desc = "Goto Definition" })
map('n', "gr", function() snacks.picker.lsp_references() end, {nowait = true, desc = "References" })
map('n', "gI", function() snacks.picker.lsp_implementations() end, {desc = "Goto Implementation" })
map('n', "gy", function() snacks.picker.lsp_type_definitions() end, {desc = "Goto T[y]pe Definition" })
map('n', "<leader>ss", function() snacks.picker.lsp_symbols() end, {desc = "LSP Symbols" })

-- Diagnostic key mappings
map('n', '<leader>qk', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', '<leader>qj', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- map('n', '<leader>qe', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>qq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
map('n', '<leader>qs', function () snacks.picker.diagnostics() end, { desc = 'Find diagnostics' })

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
map({"t", "n"}, "<leader>`", function () snacks.terminal() end, { desc = "Select terminal"})

if package.loaded['betterTerm'] then
  local betterTerm = require('betterTerm')
  map("t", "qq", "<c-\\><c-n>")
  map({"t"}, "<leader>tk", "<c-\\><c-n><c-w>k", { desc = "Move up from terminal"})
  map({"t"}, "<leader>wk", "<c-\\><c-n><c-w>k", { desc = "Move up from terminal"})
  map({"t"}, "<leader>tj", "<c-\\><c-n><c-w>j", { desc = "Move down from terminal"})
  map({"t"}, "<leader>wj", "<c-\\><c-n><c-w>j", { desc = "Move down from terminal"})
  map({"n"}, "<leader>tk", "<c-w>ki", { desc = "Move up from terminal"})
  map({"n"}, "<leader>tj", "<c-w>ji", { desc = "Move down from terminal"})
  map({"n"}, "<leader>tt", betterTerm.select, { desc = "Select terminal"})
  map({"n"}, "<leader>`", betterTerm.select, { desc = "Select terminal"})
  map({"t"}, "<leader>`", betterTerm.select, { desc = "Select terminal"})
  -- Create new term
  local current = 2
  map({"n"}, "<leader>tn", function()
      betterTerm.open(current)
      current = current + 1
  end, { desc = "New terminal" })
end

-- Navigate between panes in tmux
map({"n"}, "<C-h>", ":TmuxNavigateLeft<CR>", opts)
map({"n"}, "<C-l>", ":TmuxNavigateRight<CR>", opts)
map({"n"}, "<C-j>", ":TmuxNavigateDown<CR>", opts)
map({"n"}, "<C-k>", ":TmuxNavigateUp<CR>", opts)


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
    map('n', '<leader>hb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
    -- map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
  end,
})
-- vim.keymap.set("i", "<Tab>", function()
--     require("neocodeium").accept()
-- end)
-- vim.keymap.set("i", "<A-Tab>", function()
--     require("neocodeium").accept_word()
-- end)
-- vim.keymap.set("i", "<A-a>", function()
--     require("neocodeium").accept_line()
-- end)
-- vim.keymap.set("i", "<A-u>", function()
--     require("neocodeium").cycle_or_complete()
-- end)
-- vim.keymap.set("i", "<A-i>", function()
--     require("neocodeium").cycle_or_complete(-1)
-- end)
-- vim.keymap.set("i", "<A-y>", function()
--     require("neocodeium").clear()
-- end)
