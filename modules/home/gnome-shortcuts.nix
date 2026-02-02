{
  pkgs,
  username,
  lib,
  ...
}:
{
  home-manager.users.${username} = {
    dconf.settings = {
      # Custom Keybindings
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        ];
      };

      # Super+Enter = Terminal
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Terminal";
        command = "kgx";
        binding = "<Super>Return";
      };

      # Super+E = File Manager
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        name = "File Manager";
        command = "nautilus";
        binding = "<Super>e";
      };

      # Super+B = Browser
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        name = "Browser";
        command = "firefox";
        binding = "<Super>b";
      };

      # Super+Shift+S = Screenshot Area
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
        name = "Screenshot Area";
        command = "gnome-screenshot -a";
        binding = "<Super><Shift>s";
      };

      # Window Management Shortcuts
      "org/gnome/desktop/wm/keybindings" = {
        close = ["<Super><Shift>q"];
        toggle-fullscreen = ["<Super>f"];
        minimize = ["<Super>m"];
        toggle-maximized = ["<Super>Up"];

        # Switch Workspaces
        switch-to-workspace-1 = ["<Super>1"];
        switch-to-workspace-2 = ["<Super>2"];
        switch-to-workspace-3 = ["<Super>3"];
        switch-to-workspace-4 = ["<Super>4"];

        # Move Window to Workspace
        move-to-workspace-1 = ["<Super><Shift>1"];
        move-to-workspace-2 = ["<Super><Shift>2"];
        move-to-workspace-3 = ["<Super><Shift>3"];
        move-to-workspace-4 = ["<Super><Shift>4"];
      };

      # Shell Shortcuts
      "org/gnome/shell/keybindings" = {
        toggle-overview = ["<Super>d"];
        toggle-application-view = ["<Super>a"];
      };

      # Mutter (window tiling)
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = ["<Super>Left"];
        toggle-tiled-right = ["<Super>Right"];
      };
    };
  };
}
