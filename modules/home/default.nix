{
  username,
  ...
}:
{
  imports = [
    ./packages
    ./git
    ./starship
    ./zsh
    ./neovim
    ./tmux
    ./docker
    ./laravel
  ];

  nixpkgs.config.allowUnfree = true;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.${username}.home.stateVersion = "24.11";
}
