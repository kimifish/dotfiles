
local fb_actions = require "telescope._extensions.file_browser.actions"

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  extensions = {
    file_browser = {
      path = vim.loop.cwd(),
      cwd = vim.loop.cwd(),
      cwd_to_path = false,
      grouped = false,
      files = true,
      add_dirs = true,
      depth = 1,
      auto_depth = false,
      select_buffer = false,
      hidden = { file_browser = false, folder_browser = false },
      respect_gitignore = vim.fn.executable "fd" == 1,
      no_ignore = false,
      follow_symlinks = true,
      browse_files = require("telescope._extensions.file_browser.finders").browse_files,
      browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
      hide_parent_dir = false,
      collapse_dirs = false,
      prompt_path = false,
      quiet = false,
      dir_icon = "",
      dir_icon_hl = "Default",
      display_stat = { date = true, size = true, mode = true },
      hijack_netrw = false,
      use_fd = true,
      git_status = true,
      mappings = {
        ["i"] = {
          ["<A-c>"] = fb_actions.create,
          ["<S-CR>"] = fb_actions.create_from_prompt,
          ["<A-r>"] = fb_actions.rename,
          ["<A-m>"] = fb_actions.move,
          ["<A-y>"] = fb_actions.copy,
          ["<A-d>"] = fb_actions.remove,
          ["<C-o>"] = fb_actions.open,
          ["<C-g>"] = fb_actions.goto_parent_dir,
          ["<C-e>"] = fb_actions.goto_home_dir,
          ["<C-w>"] = fb_actions.goto_cwd,
          ["<C-t>"] = fb_actions.change_cwd,
          ["<C-f>"] = fb_actions.toggle_browser,
          ["<C-h>"] = fb_actions.toggle_hidden,
          ["<C-s>"] = fb_actions.toggle_all,
          ["<bs>"] = fb_actions.backspace,
        },
        ["n"] = {
          ["c"] = fb_actions.create,
          ["r"] = fb_actions.rename,
          ["m"] = fb_actions.move,
          ["y"] = fb_actions.copy,
          ["d"] = fb_actions.remove,
          ["o"] = fb_actions.open,
          ["g"] = fb_actions.goto_parent_dir,
          ["e"] = fb_actions.goto_home_dir,
          ["w"] = fb_actions.goto_cwd,
          ["t"] = fb_actions.change_cwd,
          ["f"] = fb_actions.toggle_browser,
          ["h"] = fb_actions.toggle_hidden,
          ["s"] = fb_actions.toggle_all,
        },
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
