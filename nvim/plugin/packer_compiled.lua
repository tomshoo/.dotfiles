-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/gh0st/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/gh0st/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/gh0st/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/gh0st/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/gh0st/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  ["alpha-nvim"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["bclose.vim"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/bclose.vim",
    url = "https://github.com/rbgrouleff/bclose.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    after = { "lsp-format.nvim" },
    after_files = { "/home/gh0st/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    config = { "\27LJ\2\nÂ\1\0\0\4\0\v\0\0286\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1B\1\1\0029\1\5\1\a\1\6\0X\1\3Ä+\1\2\0L\1\2\0X\1\14Ä9\1\a\0'\3\b\0B\1\2\2\14\0\1\0X\1\5Ä9\1\t\0'\3\n\0B\1\2\2\19\1\1\0X\2\3Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0K\0\1\0\fComment\20in_syntax_group\fcomment\26in_treesitter_capture\6c\tmode\18nvim_get_mode\bapi\bvim\23cmp.config.context\frequire1\0\1\4\1\2\0\5-\1\0\0009\1\0\0019\3\1\0B\1\2\1K\0\1\0\1¿\tbody\19expand_snippet†\1\0\1\3\2\4\0\21-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\vÄ-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4Ä-\1\1\0009\1\3\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\1¿\22expand_or_advance\26can_expand_or_advance\21select_next_item\fvisibleé\1\0\1\4\2\4\0\23-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\rÄ-\1\1\0009\1\2\1)\3ˇˇB\1\2\2\15\0\1\0X\2\5Ä-\1\1\0009\1\3\1)\3ˇˇB\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\1¿\tjump\rcan_jump\21select_prev_item\fvisible€\5\1\0\v\0.\0\\6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0005\4\5\0003\5\4\0=\5\6\0045\5\b\0003\6\a\0=\6\t\5=\5\n\0049\5\v\0009\5\f\0059\5\r\0055\a\15\0009\b\v\0009\b\14\b)\n¸ˇB\b\2\2=\b\16\a9\b\v\0009\b\14\b)\n\4\0B\b\2\2=\b\17\a9\b\v\0009\b\18\bB\b\1\2=\b\19\a9\b\v\0009\b\20\bB\b\1\2=\b\21\a9\b\v\0009\b\22\b5\n\23\0B\b\2\2=\b\24\a9\b\v\0009\b\25\bB\b\1\2=\b\26\a9\b\v\0009\b\27\bB\b\1\2=\b\28\a9\b\v\0003\n\29\0B\b\2\2=\b\30\a9\b\v\0003\n\31\0B\b\2\2=\b \aB\5\2\2=\5\v\0044\5\6\0005\6!\0>\6\1\0055\6\"\0>\6\2\0055\6#\0>\6\3\0055\6$\0>\6\4\0055\6%\0>\6\5\5=\5&\4B\2\2\0019\2\3\0009\2'\2'\4(\0005\5*\0004\6\3\0005\a)\0>\a\1\6=\6&\5B\2\3\0019\2\3\0009\2'\2'\4+\0005\5-\0004\6\3\0005\a,\0>\a\1\6=\6&\5B\2\3\0012\0\0ÄK\0\1\0\1\0\0\1\0\1\tname\vbuffer\6/\1\0\0\1\0\1\tname\fcmdline\6:\fcmdline\fsources\1\0\1\tname\rnvim_lua\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\1\0\1\tname\vsnippy\f<S-Tab>\0\n<Tab>\0\v<Down>\21select_next_item\t<Up>\21select_prev_item\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\fsnippet\vexpand\1\0\0\0\fenabled\1\0\0\0\nsetup\vsnippy\bcmp\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-snippy"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/cmp-snippy",
    url = "https://github.com/dcampos/cmp-snippy"
  },
  colorizer = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/colorizer",
    url = "https://github.com/lilydjwg/colorizer"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n∆\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\21filetype_exclude\1\2\0\0\rstartify\1\0\4\31show_current_context_start\2\25show_current_context\2\21show_end_of_line\2\25space_char_blankline\6 \nsetup\21indent_blankline\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-format.nvim"] = {
    config = { "\27LJ\2\n«\1\0\0\4\0\t\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0006\2\5\0009\2\6\0029\2\a\0029\2\b\2B\2\1\0A\0\0\0026\1\0\0'\3\6\0B\1\2\0029\1\2\1\18\3\0\0B\1\2\1K\0\1\0\29make_client_capabilities\rprotocol\blsp\bvim\24update_capabilities\17cmp_nvim_lsp\nsetup\15lsp-format\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/opt/lsp-format.nvim",
    url = "https://github.com/lukas-reineke/lsp-format.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["minimap.vim"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/minimap.vim",
    url = "https://github.com/wfxr/minimap.vim"
  },
  ["mkdir.nvim"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/mkdir.nvim",
    url = "https://github.com/jghauser/mkdir.nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/nerdcommenter",
    url = "https://github.com/preservim/nerdcommenter"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\ny\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21disable_filetype\1\0\1\rcheck_ts\2\1\3\0\0\fscratch\vnofile\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    after = { "cmp-nvim-lsp" },
    loaded = true,
    only_config = true
  },
  ["nvim-snippy"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/nvim-snippy",
    url = "https://github.com/dcampos/nvim-snippy"
  },
  ["nvim-terminal"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/nvim-terminal",
    url = "https://github.com/s1n7ax/nvim-terminal"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-yati", "indent-blankline.nvim" },
    config = { "\27LJ\2\n¿\2\0\0\4\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\vindent\1\0\1\venable\2\14highlight\1\0\3&additional_vim_regex_highlighting\2\venable\2\21use_languagetree\2\21ensure_installed\1\14\0\0\6c\blua\trust\vpython\bvim\ttoml\tbash\fcomment\trasi\tjson\njsonc\bcpp\rmarkdown\tyati\1\0\1\17sync_install\1\1\0\1\venable\2\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["nvim-yati"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/opt/nvim-yati",
    url = "https://github.com/yioneko/nvim-yati"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\17silent_chdir\1\nsetup\17project_nvim\frequire\0" },
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["rust-tools.nvim"] = {
    config = { "\27LJ\2\nk\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\vserver\1\0\1\15standalone\1\1\0\1\17autoSetHints\2\nsetup\15rust-tools\frequire\0" },
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/tami5/sqlite.lua"
  },
  tabular = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  tagbar = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/tagbar",
    url = "https://github.com/preservim/tagbar"
  },
  ["telescope-frecency.nvim"] = {
    config = { "\27LJ\2\nà\1\0\0\3\0\6\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0'\2\4\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0'\2\5\0B\0\2\1K\0\1\0\rprojects\rfrecency\19load_extension\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nΩ\1\0\0\5\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\3B\1\2\1K\0\1\0\nsigns\1\0\4\fwarning\v[warn]\nerror\f[error]\thint\v[help]\16information\v[info]\1\0\3\16fold_closed\b>>+\17indent_lines\2\25use_diagnostic_signs\1\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-colortemplate"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/vim-colortemplate",
    url = "https://github.com/lifepillar/vim-colortemplate"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/vim-markdown",
    url = "https://github.com/preservim/vim-markdown"
  },
  ["vim-misc"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/vim-misc",
    url = "https://github.com/xolox/vim-misc"
  },
  ["vim-session"] = {
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/vim-session",
    url = "https://github.com/xolox/vim-session"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/gh0st/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nΩ\1\0\0\5\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\3B\1\2\1K\0\1\0\nsigns\1\0\4\fwarning\v[warn]\nerror\f[error]\thint\v[help]\16information\v[info]\1\0\3\16fold_closed\b>>+\17indent_lines\2\25use_diagnostic_signs\1\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: telescope-frecency.nvim
time([[Config for telescope-frecency.nvim]], true)
try_loadstring("\27LJ\2\nà\1\0\0\3\0\6\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0'\2\4\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0'\2\5\0B\0\2\1K\0\1\0\rprojects\rfrecency\19load_extension\nsetup\14telescope\frequire\0", "config", "telescope-frecency.nvim")
time([[Config for telescope-frecency.nvim]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\17silent_chdir\1\nsetup\17project_nvim\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n_\0\0\4\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\1K\0\1\0\1\0\1\27automatic_installation\2\nsetup\23nvim-lsp-installer\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: rust-tools.nvim
time([[Config for rust-tools.nvim]], true)
try_loadstring("\27LJ\2\nk\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\vserver\1\0\1\15standalone\1\1\0\1\17autoSetHints\2\nsetup\15rust-tools\frequire\0", "config", "rust-tools.nvim")
time([[Config for rust-tools.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\ny\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21disable_filetype\1\0\1\rcheck_ts\2\1\3\0\0\fscratch\vnofile\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd cmp-nvim-lsp ]]

-- Config for: cmp-nvim-lsp
try_loadstring("\27LJ\2\nÂ\1\0\0\4\0\v\0\0286\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1B\1\1\0029\1\5\1\a\1\6\0X\1\3Ä+\1\2\0L\1\2\0X\1\14Ä9\1\a\0'\3\b\0B\1\2\2\14\0\1\0X\1\5Ä9\1\t\0'\3\n\0B\1\2\2\19\1\1\0X\2\3Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0K\0\1\0\fComment\20in_syntax_group\fcomment\26in_treesitter_capture\6c\tmode\18nvim_get_mode\bapi\bvim\23cmp.config.context\frequire1\0\1\4\1\2\0\5-\1\0\0009\1\0\0019\3\1\0B\1\2\1K\0\1\0\1¿\tbody\19expand_snippet†\1\0\1\3\2\4\0\21-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\vÄ-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4Ä-\1\1\0009\1\3\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\1¿\22expand_or_advance\26can_expand_or_advance\21select_next_item\fvisibleé\1\0\1\4\2\4\0\23-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\rÄ-\1\1\0009\1\2\1)\3ˇˇB\1\2\2\15\0\1\0X\2\5Ä-\1\1\0009\1\3\1)\3ˇˇB\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\1¿\tjump\rcan_jump\21select_prev_item\fvisible€\5\1\0\v\0.\0\\6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0005\4\5\0003\5\4\0=\5\6\0045\5\b\0003\6\a\0=\6\t\5=\5\n\0049\5\v\0009\5\f\0059\5\r\0055\a\15\0009\b\v\0009\b\14\b)\n¸ˇB\b\2\2=\b\16\a9\b\v\0009\b\14\b)\n\4\0B\b\2\2=\b\17\a9\b\v\0009\b\18\bB\b\1\2=\b\19\a9\b\v\0009\b\20\bB\b\1\2=\b\21\a9\b\v\0009\b\22\b5\n\23\0B\b\2\2=\b\24\a9\b\v\0009\b\25\bB\b\1\2=\b\26\a9\b\v\0009\b\27\bB\b\1\2=\b\28\a9\b\v\0003\n\29\0B\b\2\2=\b\30\a9\b\v\0003\n\31\0B\b\2\2=\b \aB\5\2\2=\5\v\0044\5\6\0005\6!\0>\6\1\0055\6\"\0>\6\2\0055\6#\0>\6\3\0055\6$\0>\6\4\0055\6%\0>\6\5\5=\5&\4B\2\2\0019\2\3\0009\2'\2'\4(\0005\5*\0004\6\3\0005\a)\0>\a\1\6=\6&\5B\2\3\0019\2\3\0009\2'\2'\4+\0005\5-\0004\6\3\0005\a,\0>\a\1\6=\6&\5B\2\3\0012\0\0ÄK\0\1\0\1\0\0\1\0\1\tname\vbuffer\6/\1\0\0\1\0\1\tname\fcmdline\6:\fcmdline\fsources\1\0\1\tname\rnvim_lua\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\1\0\1\tname\vsnippy\f<S-Tab>\0\n<Tab>\0\v<Down>\21select_next_item\t<Up>\21select_prev_item\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\fsnippet\vexpand\1\0\0\0\fenabled\1\0\0\0\nsetup\vsnippy\bcmp\frequire\0", "config", "cmp-nvim-lsp")

vim.cmd [[ packadd lsp-format.nvim ]]

-- Config for: lsp-format.nvim
try_loadstring("\27LJ\2\n«\1\0\0\4\0\t\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0006\2\5\0009\2\6\0029\2\a\0029\2\b\2B\2\1\0A\0\0\0026\1\0\0'\3\6\0B\1\2\0029\1\2\1\18\3\0\0B\1\2\1K\0\1\0\29make_client_capabilities\rprotocol\blsp\bvim\24update_capabilities\17cmp_nvim_lsp\nsetup\15lsp-format\frequire\0", "config", "lsp-format.nvim")

time([[Sequenced loading]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufNewFile * ++once lua require("packer.load")({'nvim-treesitter'}, { event = "BufNewFile *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-treesitter'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'nvim-treesitter'}, { event = "BufEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
