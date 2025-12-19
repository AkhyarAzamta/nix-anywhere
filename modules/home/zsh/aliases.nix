{ username, ... }:
{
  home-manager.users.${username}.programs.zsh.shellAliases = {
    c = "clear";
    v = "nvim";
    t = "tmux";
    cl = "claude";
    ls = "eza --icons";
    ll = "eza -la --icons";
    la = "eza -a --icons";
    lt = "eza --tree --icons";
    l = "eza -l --icons";
    cat = "bat";
  };
}
