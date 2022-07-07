local onedark = require("onedark")
onedark.setup{
    transparent = false,
    style = "cool"
}
onedark.load()
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.onedark_terminal_italics = 1
if os.getenv("XDG_SESSION_TYPE") == "wayland"
then
    vim.opt.guifont={"Fira Code", ":h11"}
else
    vim.opt.guifont={"Fira Code", ":h7"}
end
