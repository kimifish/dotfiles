
-- document existing key chains
require('which-key').add({
  { "<leader>b", group = "[B]uffer" },
  { "<leader>b_", hidden = true },
  { "<leader>c", group = "[C]ode" },
  { "<leader>c_", hidden = true },
  { "<leader>d", group = "[D]ebug" },
  { "<leader>d_", hidden = true },
  { "<leader>f", group = "[F]ile" },
  { "<leader>f_", hidden = true },
  { "<leader>g", group = "[G]it" },
  { "<leader>g_", hidden = true },
  { "<leader>h", group = "Git [H]unk" },
  { "<leader>h_", hidden = true },
  { "<leader>l", group = "LSP" },
  { "<leader>l_", hidden = true },
  { "<leader>r", group = "[R]un" },
  { "<leader>r_", hidden = true },
  { "<leader>s", group = "[S]earch" },
  { "<leader>s_", hidden = true },
  { "<leader>t", group = "[T]erminal" },
  { "<leader>t_", hidden = true },
  { "<leader>w", group = "[W]orkspace" },
  { "<leader>w_", hidden = true },
})
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').add({
  { "<leader>", group = "VISUAL <leader>", mode = "v" },
  { "<leader>h", desc = "Git [H]unk", mode = "v" },
}, { mode = 'v' })

-- Normal mode by double q and i 
vim.keymap.set("i", "qq", "<esc>", { noremap = true, silent = true })
vim.keymap.set("i", "jk", "<esc>", { noremap = true, silent = true })

-- Using H/L to go to the begining and the end of line
-- Note: H will map to _ (the first non-whitespace character of a line)
-- It would be helpful if it is a indent line in some languages like Python, Ruby, YAML, ...
vim.keymap.set('n', 'H', '_', { noremap = true, silent = true })
vim.keymap.set('n', 'L', '$', { noremap = true, silent = true })

-- More convinient vertical movement
vim.keymap.set("n", "<C-u>", "<C-u>zz", {});
vim.keymap.set("n", "<C-d>", "<C-d>zz", {});
vim.o.scrolloff = 8;

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- See `:help telescope.builtin`
local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end
--
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

  -- You can pass additional configuration to telescope to change theme, layout, etc.
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR><Esc>", { noremap = true })

-- cokeline mappings
vim.keymap.set("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
vim.keymap.set("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
vim.keymap.set("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
vim.keymap.set("n", "<Leader>bp", "<Plug>(cokeline-switch-prev)", { silent = true, desc = "Switch with [n]ext buffer" })
vim.keymap.set("n", "<Leader>bn", "<Plug>(cokeline-switch-next)", { silent = true, desc = "Switch with [p]rev buffer" })
vim.keymap.set("n", "<Leader>bd", "<Plug>(cokeline-focus-close)", { silent = true, desc = "[D]elete buffer" })
vim.keymap.set("n", "<leader>bb", function()
    require('cokeline.mappings').pick("focus")
end, { desc = "Pick a buffer to focus" })
-- Assign buffers to leader-1-0
for i = 1, 9 do
  vim.keymap.set("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
end

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- DEBUG Mappings --
-- Toggle see whitespace characters like: eol, space, ...
vim.keymap.set('n', '<leader>dw', ':set list!<cr>', {desc = "Show [W]hitespace chars"})
-- vim.keymap.set('n', '<leader>do', require('dapui').open , { desc = 'Debug open' })
-- vim.keymap.set('n', '<leader>do', require('dapui').close , { desc = 'Debug close' })
vim.keymap.set('n', '<leader>dd', require('dapui').toggle, { desc = 'Debug windows' })
vim.keymap.set('n', '<leader>dc', require 'dap'.continue, { desc = "[C]ontinue"})
vim.keymap.set('n', '<leader>do', require 'dap'.step_over, { desc = "Step [o]ver"})
vim.keymap.set('n', '<leader>di', require 'dap'.step_into, { desc = "Step [i]nto"})
vim.keymap.set('n', '<leader>du', require 'dap'.step_out, { desc = "Step o[u]t" })
vim.keymap.set('n', '<leader>db', require("dap").toggle_breakpoint, { desc = "Breakpoint" })
vim.keymap.set('n', '<F5>', require 'dap'.continue)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.fn.sign_define('DapBreakpoint',{ text ='●', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='→', texthl ='', linehl ='', numhl =''})

vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })

-- Open NvimTree (closing by 'q')
vim.keymap.set('n', 'ff', ':NvimTreeOpen<CR>', { noremap = true, silent = false })
local betterTerm = require('betterTerm')
-- vim.keymap.set({"n", "t"}, "<leader>`", betterTerm.open, { desc = "Open terminal"})

-- Normal mode in terminal
vim.keymap.set("t", "qq", "<c-\\><c-n>")
-- Select term focus
vim.keymap.set({"t"}, "<leader>tk", "<c-\\><c-n><c-w>k", { desc = "Move up from terminal"})
vim.keymap.set({"t"}, "<leader>tj", "<c-\\><c-n><c-w>j", { desc = "Move down from terminal"})
vim.keymap.set({"n"}, "<leader>tk", "<c-w>ki", { desc = "Move up from terminal"})
vim.keymap.set({"n"}, "<leader>tj", "<c-w>ji", { desc = "Move down from terminal"})
vim.keymap.set({"n"}, "<leader>tt", betterTerm.select, { desc = "Select terminal"})
vim.keymap.set({"n"}, "<leader>`", betterTerm.select, { desc = "Select terminal"})
-- Create new term
local current = 2
vim.keymap.set(
    {"n"}, "<leader>tn",
    function()
        betterTerm.open(current)
        current = current + 1
    end,
    { desc = "New terminal"}
)
