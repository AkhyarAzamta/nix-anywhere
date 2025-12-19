{ username, ... }:
{
  home-manager.users.${username}.programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
