{
  pkgs,
  username,
  ...
}:
{
  users.groups.plugdev = { };

  users.users.${username} = {
    isNormalUser = true;
    description = "Akhyar Azamta";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "audio"
      "video"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
}
