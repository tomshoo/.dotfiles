vim.g.neovide_cursor_vfx_mode = "railgun"
if os.getenv("WAYLAND_DISPLAY")
then
    vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h10" }
else
    vim.opt.guifont = { "FiraCode Nerd Font", ":h7" }
end
