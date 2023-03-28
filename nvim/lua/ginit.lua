vim.g.neovide_cursor_vfx_mode = "railgun"
if os.getenv("WINIT_UNIX_BACKEND") == "wayland"
then
    vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h10" }
else
    vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h10" }
end
