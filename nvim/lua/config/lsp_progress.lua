local M = {}

local cfg = {
    text = {
        spinner = {
            [=[[~][=>  ] ]=],
            [=[[\][==> ] ]=],
            [=[[|][===>] ]=],
            [=[[/][====] ]=],
            [=[[~][>===] ]=],
            [=[[\][ >==] ]=],
            [=[[|][  >=] ]=],
            [=[[/][  <=] ]=],
            [=[[~][ <==] ]=],
            [=[[\][<===] ]=],
            [=[[|][====] ]=],
            [=[[/][===<] ]=],
            [=[[~][==< ] ]=],
            [=[[ ][=<  ] ]=],
        }
    },
    window = {
        border = "none"
    },
    sources = {
        ['null-ls'] = { ignore = true }
    }
}

function M.setup()
    local ok, fidget = pcall(require, 'fidget')
    if not ok then
        return false
    end

    fidget.setup(cfg)
    return true
end

return M
