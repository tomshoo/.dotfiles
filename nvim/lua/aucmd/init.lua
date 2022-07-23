local autable = {
    "aucmd.reload",
    "aucmd.filetypes",
    "aucmd.others"
}

for _, conf in ipairs(autable) do
    local ok, group = pcall(require, conf)
    if ok then
        group.setup()
    end
end
