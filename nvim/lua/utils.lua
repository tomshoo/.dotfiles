-- Launch Scratchpad to well.. scratch
_G.scratchpad = function()
    vim.cmd [[
        vsplit
        noswapfile hide enew
        file scratch
    ]]
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "hide"
    vim.bo.filetype = "scratch"
end

-- VSCode like Home key
_G.extended_home = function()
    local col = vim.fn.col('.')
    vim.cmd "normal! ^"
    if col == vim.fn.col('.') then
        vim.cmd "normal! 0"
    end
end
