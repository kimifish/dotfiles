
return {
-- prefil edit window with common scenarios to avoid repeating query and submit immediately
prefill_edit_window = function(request)
    require('avante.api').edit()
    local code_bufnr = vim.api.nvim_get_current_buf()
    local code_winid = vim.api.nvim_get_current_win()
    if code_bufnr == nil or code_winid == nil then
      return
    end
    vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
    -- Optionally set the cursor position to the end of the input
    vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
    -- Simulate Ctrl+S keypress to submit
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-s>', true, true, true), 'v', true)
end,

-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
grammar_correction = 'Correct the text to standard English, but keep any code blocks inside intact.',
keywords = 'Extract the main keywords from the following text',
code_readability_analysis = [[
You must identify any readability issues in the code snippet.
Some readability issues to consider:
- Unclear naming
- Unclear purpose
- Redundant or obvious comments
- Lack of comments
- Long or complex one liners
- Too much nesting
- Long variable names
- Inconsistent naming and code style.
- Code repetition
You may identify additional problems. The user submits a small section of code from a larger file.
Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
If there's no issues with code respond with only: <OK>
]],
optimize_code = 'Optimize the following code',
summarize = 'Summarize the following text',
translate = 'Translate this into Russian, but keep any code blocks inside intact',
avante_translate_comments_to_en = 'Translate comments into English, but keep any code blocks inside intact',
explain_code = 'Explain the following code',
complete_code = 'Complete the following codes written in ' .. vim.bo.filetype,
add_docstring = 'Add docstring to the following codes',
fix_bugs = 'Fix the bugs inside the following codes if any',
add_tests = 'Implement tests for the following code',
}

