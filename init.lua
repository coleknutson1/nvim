vim.cmd.colorscheme("retrobox")
vim.g.mapleader = ' '
vim.wo.number = true
vim.opt.swapfile = false
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	pattern = {"*.c", "*.h"},
	callback = function()
		local current_file_name = vim.api.nvim_buf_get_name(0) 
		print(current_file_name)
--		vim.keymap.set('n', 'F5', 
	end
})
-- Add this to your init.lua
vim.keymap.set('n', '<F5>', function()
    -- Save the current buffer
    vim.cmd('write')
    
    -- Get the current file path
    local file = vim.fn.expand('%:p')
    local file_name = vim.fn.expand('%:t:r')
    
    -- Create the compilation command
    local compile_cmd = string.format('zig cc -o %s %s', file_name, file)
    
    -- Create a new terminal buffer and compile
    vim.cmd('botright new')
    vim.fn.termopen(compile_cmd, {
        on_exit = function(job_id, exit_code)
            if exit_code == 0 then
                -- If compilation successful, run the program
                vim.fn.termopen('./' .. file_name)
            end
        end,
        cwd = vim.fn.expand('%:p:h')
    })
end, { noremap = true, silent = true, desc = 'Compile and run C program' })
