{ username, ... }:
{
  home-manager.users.${username}.programs.git = {
    enable = true;
    settings = {
      user.name = "maulanasdqn";
      user.email = "maulanasdqn@gmail.com";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
