local function set_cursor_color()
    -- Get the current keyboard layout
    local layout = vim.system({"xkblayout-state", "print", "%n"}, { text = true }):wait()
    -- vim.notify("layout = " .. layout.stdout, "info", { title = "Layout" })
    if layout.stdout == "English" then
        -- Change cursor color for English layout
        vim.cmd([[highlight CursorLine cterm=NONE ctermbg=DarkGray guibg=#373944]])
    else
        -- Change cursor color for other layouts
        vim.cmd([[highlight CursorLine cterm=NONE ctermbg=DarkGray guibg=#44373f]])
    end
end

-- Call set_cursor_color when Neovim starts and when focus is gained
-- vim.api.nvim_create_autocmd({"CursorMoved", }, {
--     callback = set_cursor_color,
-- })
