vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.onedark_terminal_italics = 1
if os.getenv("WAYLAND_DISPLAY")
then
    vim.opt.guifont = { "FiraCode Nerd Font", ":h11" }
else
    vim.opt.guifont = { "FiraCode Nerd Font", ":h7" }
end
