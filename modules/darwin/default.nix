{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [
    ./system.nix
  ];

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
}
