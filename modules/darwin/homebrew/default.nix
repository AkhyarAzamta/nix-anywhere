{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };

    # Formulae (CLI tools & services)
    brews = [
      "mysql"
      "postgresql@16"
      "redis"
    ];

    # GUI Apps
    casks = [
      "microsoft-edge"
      "ghostty"
      "postman"
    ];
  };
}
