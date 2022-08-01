vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.onedark_terminal_italics = 1
if os.getenv("XDG_SESSION_TYPE") == "wayland"
then
    vim.opt.guifont = { "Iosevka Nerd Font", ":h12" }
else
    vim.opt.guifont = { "FiraCode Nerd Font", ":h7" }
end
