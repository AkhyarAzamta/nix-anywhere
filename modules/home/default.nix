{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [
    ./zsh.nix
    ./neovim.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${username} = {
    home.stateVersion = "24.11";

    # User packages
    home.packages = with pkgs; [
      ripgrep
      fd
      fzf
      eza
      bat
      jq
      tree
      volta
      ghostty
    ];

    # Volta environment
    home.sessionVariables = {
      VOLTA_HOME = "$HOME/.volta";
    };

    home.sessionPath = [
      "$HOME/.volta/bin"
    ];

    programs.git = {
      enable = true;
      settings = {
        user.name = "maulanasdqn";
        user.email = "maulanasdqn@gmail.com";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
