CTable = {}

local fn = vim.fn

function CTable.ReloadConfig()
    local cfgpath = fn.stdpath('config')
    local current_file = fn.expand('%:p')
    if current_file == cfgpath .. '/init.lua' then
        vim.cmd [[
            source %
        ]]
    elseif current_file == cfgpath .. '/lua/plugins.lua' then
        vim.cmd [[
            source % | PackerCompile
        ]]
    end
end

function CTable.setup()
    vim.cmd [[
        autocmd BufWritePost * lua require('aucmd.reload').ReloadConfig()
    ]]
end

return CTable
