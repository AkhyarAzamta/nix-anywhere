{
  description = "Arduino development environment (PlatformIO FHS)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # Wrap PlatformIO in an FHS environment so its downloaded binaries
        # (like avrdude) that expect /bin/bash work correctly on NixOS
        platformio-fhs = pkgs.buildFHSEnv {
          name = "platformio";
          targetPkgs = pkgs: (with pkgs; [
            platformio-core
            python3
            gcc
            glibc
            pkg-config
            libusb1
            zlib
            systemd
            gnumake
            cmake
            ncurses5
            ncurses
          ]);
          runScript = "platformio";
        };

        # Also wrap pio (short alias)
        pio-fhs = pkgs.buildFHSEnv {
          name = "pio";
          targetPkgs = pkgs: (with pkgs; [
            platformio-core
            python3
            gcc
            glibc
            pkg-config
            libusb1
            zlib
            systemd
            gnumake
            cmake
            ncurses5
            ncurses
          ]);
          runScript = "pio";
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            platformio-fhs
            pio-fhs
            pkgs.avrdude
          ];

          shellHook = ''
            echo "Arduino Development Environment"
            echo "Commands: platformio, pio (both run inside FHS)"
            echo ""
          '';
        };
      }
    );
}
