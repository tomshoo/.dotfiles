-- global variable for configuration load status
_M = {}

-- Launch Scratchpad to well.. scratch
_G.scratchpad = function()
    vim.cmd [[
        vsplit
        noswapfile hide enew
        file /tmp/scratch
    ]]
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "hide"
    vim.bo.filetype = "scratch"
end

-- Home key decides where to go based on current position
_G.extended_home = function()
    local col = vim.fn.col('.')
    vim.cmd.normal({ "^", bang = true })
    if col == vim.fn.col('.') then
        vim.cmd "normal! 0"
        vim.cmd.normal({ "0", bang = true })
    end
end
