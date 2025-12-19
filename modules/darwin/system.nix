{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  # System state version
  system.stateVersion = 5;

  # Primary user for user-specific settings
  system.primaryUser = username;

  # Enable Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Passwordless sudo for user
  environment.etc."sudoers.d/10-nix-darwin".text = ''
    ${username} ALL=(ALL) NOPASSWD: ALL
  '';

  # System packages available to all users
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];

  # macOS system defaults
  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    dock = {
      autohide = true;
      show-recents = false;
      tilesize = 48;
    };
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];
}
