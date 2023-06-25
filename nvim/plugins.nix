{ pkgs, ... }: {
  programs.neovim.plugins = (with pkgs.vimPlugins; 
    [ FixCursorHold-nvim
      nvim-hlslens
      tabular
      bclose-vim
      vim-tmux-navigator
      wilder-nvim
      which-key-nvim

      undotree
      neogit
      gitsigns-nvim

      nvim-web-devicons
      barbar-nvim
      lualine-nvim

      nvim-autopairs
      nvim-surround
      comment-nvim

      nvim-lspconfig
      null-ls-nvim
      lsp_signature-nvim
      rust-tools-nvim
      trouble-nvim
      fidget-nvim

      nvim-cmp
      nvim-snippy
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-nvim-lua
      cmp-snippy
      crates-nvim

      nvim-dap
      nvim-dap-ui

      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-treesitter-textobjects

      telescope-nvim
      plenary-nvim
      telescope-ui-select-nvim
      telescope-frecency-nvim

      sonokai
    ]);
}
