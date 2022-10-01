local M = {
    org_agenda_files = "~/Documents/org/agenda/**/**",
    org_default_notes_file = "~/Documents/org/notes/default.org",
    mappings = {
        org_return = false
    }
}

function M.setup()
    local ok, orgmode = pcall(require, 'orgmode')
    if not ok then
        return false
    end

    orgmode.setup()
    orgmode.setup_ts_grammar()
end

return M
