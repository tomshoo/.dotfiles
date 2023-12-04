{ config, pkgs, ... }: let
zellij-session-manager = pkgs.writeShellScriptBin "zj"    (builtins.readFile ./scripts/zj);
tmux-session-manager   = pkgs.writeShellScriptBin "tsman" (builtins.readFile ./scripts/tsman);

in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tomshoo";
  home.homeDirectory = "/home/tomshoo";
  # home.useGlobalPackages = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [
    zellij-session-manager
    tmux-session-manager
  ];

  home.file = {
    ".config/zsh".source    = ./zsh;
    ".config/river".source  = ./river;
    ".config/mako".source   = ./mako;
    ".config/zellij".source = ./zellij;
    ".config/nvim".source   = ./nvim;

    ".bashrc".source      = ./bashrc;
    ".config/bash".source = ./bash;

    ".config/kitty/kitty.conf".source         = ./kitty/kitty.conf;
    ".config/kitty/current-theme.conf".source = ./kitty/current-theme.conf;
  };

  home.sessionVariables = {
    EDITOR          = "nvim";
    XDG_DATA_HOME   = "${config.xdg.dataHome}";
    XDG_CONFIG_HOME = "${config.xdg.configHome}";
    XDG_CACHE_HOME  = "${config.xdg.cacheHome}";
    XDG_STATE_HOME  = "${config.xdg.stateHome}";
    TERMINAL        = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
