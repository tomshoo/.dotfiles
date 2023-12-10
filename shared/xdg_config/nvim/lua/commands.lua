vim.api.nvim_create_user_command("ConfigOpen", function()
    local config_path = vim.fn.stdpath('config')

    vim.cmd.cd(config_path);
    vim.cmd.edit(config_path);
end, {})
