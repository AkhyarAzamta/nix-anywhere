{
  pkgs,
  lib,
  enableLaravel,
  ...
}:
{
  services.mysql = lib.mkIf enableLaravel {
    enable = true;
    package = pkgs.mariadb;
  };
}
