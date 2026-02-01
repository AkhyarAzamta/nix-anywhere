{
  lib,
  pkgs,
  username,
  sshKeys,
  userPassword ? null,
  ...
}:
{
  # Ensure config is valid
  assertions = [
    {
      assertion = sshKeys != [];
      message = "sshKeys must not be empty - you will be locked out!";
    }
  ];

  time.timeZone = lib.mkDefault "Asia/Jakarta";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  boot = {
    loader = {
      systemd-boot.enable = lib.mkDefault true;
      efi.canTouchEfiVariables = lib.mkDefault true;
    };
    tmp.cleanOnBoot = true;
  };

  users.mutableUsers = true;

  # Only create non-root user if username is not "root"
  users.users = lib.mkMerge [
    (lib.mkIf (username != "root") {
      ${username} = {
        isNormalUser = true;
        uid = 1000;
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = sshKeys;
        createHome = true;
        home = "/home/${username}";
        
        # 🔐 PASSWORD SETTINGS - Pilih salah satu opsi di bawah:
        
        # Opsi 1: Initial password (password sementara, bisa diganti user nanti)
        initialPassword = lib.mkIf (userPassword != null) userPassword;
        
        # Opsi 2: Hashed password (lebih aman, permanent)
        # Uncomment dan ganti dengan hash password Anda
        # Generate dengan: mkpasswd -m sha-512
        # hashedPassword = "$6$rounds=656000$YourHashedPasswordHere";
        
        # Opsi 3: Password dari file terenkripsi (paling aman untuk production)
        # hashedPasswordFile = "/etc/nixos/secrets/user-password";
      };
    })
    {
      # Root user settings
      root.openssh.authorizedKeys.keys = sshKeys;
      
      # Optional: Set root password
      # Untuk workstation, bisa pakai initialPassword
      # Untuk server/VPS, DISABLE root password untuk keamanan
      # root.initialPassword = "nixos";  # Untuk workstation
      # root.hashedPassword = "!";  # Untuk server (disable root login)
    }
  ];

  programs.zsh.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;  # User di group wheel tidak perlu password untuk sudo
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    mkpasswd  # Tool untuk generate password hash
  ];

  system.stateVersion = "25.05";
}
