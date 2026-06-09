{
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        eza
        bat
        fzf
        zoxide
        ripgrep
        fd
        jq
        yq

        gparted
        gnome-disk-utility

        nodejs_22
        (pkgs.writeShellScriptBin "gemini-cli" ''
          exec ${pkgs.nodejs_22}/bin/npx -y @google/gemini-cli "$@"
        '')
        pnpm
        bun
        go
        python3
        dotnet-sdk

        docker-compose
        lazydocker

        lazygit
        gh
        delta

        ncdu
        duf
        procs
        bottom
        htop
        tldr
        brightnessctl
        swayosd

        httpie
        xh
        postman # Unstable on Linux (try --disable-gpu if crashing)

        p7zip
        unrar

        slack

        google-chrome
        antigravity
        arduino-ide

        imagemagick
        ffmpeg
      ];

      sessionVariables = {
        EDITOR = "nvim";
        GOPATH = "$HOME/go";
      };

      sessionPath = [
        "$HOME/.local/bin"
        "$HOME/go/bin"
        "$HOME/.bun/bin"
      ];
    };

    xdg.configFile."nixpkgs/config.nix".text = ''
      { allowUnfree = true; }
    '';
  };
}
