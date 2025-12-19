{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;

      # History settings
      history = {
        size = 10000;
        save = 10000;
        ignoreDups = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        share = true;
      };

      # Your aliases
      shellAliases = {
        c = "clear";
        v = "nvim";
        ls = "eza";
        ll = "eza -la";
        la = "eza -a";
        lt = "eza --tree";
        cat = "bat";
      };

      # Oh-My-Zsh configuration
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "z"
          "docker"
          "kubectl"
        ];
      };

      # Extra initialization
      initExtra = ''
        # Key bindings
        bindkey '^[[A' history-search-backward
        bindkey '^[[B' history-search-forward

        # FZF integration
        if command -v fzf &> /dev/null; then
          eval "$(fzf --zsh)"
        fi
      '';
    };

    # Zoxide (better z)
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # FZF
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
