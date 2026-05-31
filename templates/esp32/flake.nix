{
  description = "ESP32 development environment (PlatformIO)";

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
      in
      let
        # PlatformIO convenience scripts
        pio-build         = pkgs.writeShellScriptBin "pio-build"          "platformio run \"$@\"";
        pio-upload        = pkgs.writeShellScriptBin "pio-upload"         "platformio run --target upload \"$@\"";
        pio-monitor       = pkgs.writeShellScriptBin "pio-monitor"        "platformio device monitor \"$@\"";
        pio-upload-monitor = pkgs.writeShellScriptBin "pio-upload-monitor" "platformio run --target upload && platformio device monitor \"$@\"";
        pio-clean         = pkgs.writeShellScriptBin "pio-clean"          "platformio run --target clean \"$@\"";
        pio-fullclean     = pkgs.writeShellScriptBin "pio-fullclean"      "platformio run --target fullclean \"$@\"";
        pio-devices       = pkgs.writeShellScriptBin "pio-devices"        "platformio device list \"$@\"";
        pio-progsize      = pkgs.writeShellScriptBin "pio-progsize"       "platformio run --target size \"$@\"";
        pio-buildfs       = pkgs.writeShellScriptBin "pio-buildfs"        "platformio run --target buildfs \"$@\"";
        pio-uploadfs      = pkgs.writeShellScriptBin "pio-uploadfs"       "platformio run --target uploadfs \"$@\"";
        pio-uploadfs-ota  = pkgs.writeShellScriptBin "pio-uploadfs-ota"   "platformio run --target uploadfs --environment ota \"$@\"";
        pio-erase         = pkgs.writeShellScriptBin "pio-erase"          "platformio run --target erase \"$@\"";
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            platformio-core
            esptool
            python3
            gcc
            gnumake
            cmake
            pkg-config
            libusb1
            zlib
            openssl

            # PlatformIO shortcut scripts
            pio-build
            pio-upload
            pio-monitor
            pio-upload-monitor
            pio-clean
            pio-fullclean
            pio-devices
            pio-progsize
            pio-buildfs
            pio-uploadfs
            pio-uploadfs-ota
            pio-erase
          ];

          shellHook = ''
            echo "ESP32 Development Environment (PlatformIO)"
            echo ""
            echo "General:"
            echo "  pio-build          - Compile project"
            echo "  pio-upload         - Upload firmware"
            echo "  pio-monitor        - Serial monitor"
            echo "  pio-upload-monitor - Upload + monitor"
            echo "  pio-clean          - Clean build files"
            echo "  pio-fullclean      - Full clean"
            echo "  pio-devices        - List connected devices"
            echo ""
            echo "Platform:"
            echo "  pio-buildfs        - Build Filesystem Image"
            echo "  pio-progsize       - Show program size"
            echo "  pio-uploadfs       - Upload Filesystem Image"
            echo "  pio-uploadfs-ota   - Upload Filesystem Image OTA"
            echo "  pio-erase          - Erase Flash"
            echo ""

            # Fix shebangs in PlatformIO's downloaded packages
            # PlatformIO bundles binaries with #!/bin/bash which doesn't exist on NixOS
            PLATFORMIO_PACKAGES="$HOME/.platformio/packages"
            if [ -d "$PLATFORMIO_PACKAGES" ]; then
              find "$PLATFORMIO_PACKAGES" -maxdepth 3 -type f -executable 2>/dev/null | while read f; do
                if head -c 2 "$f" 2>/dev/null | grep -q '#!'; then
                  first_line=$(head -1 "$f" 2>/dev/null)
                  if echo "$first_line" | grep -q '/bin/bash'; then
                    sed -i "1s|#!/bin/bash|#!$(command -v bash)|" "$f" 2>/dev/null || true
                  elif echo "$first_line" | grep -q '/usr/bin/env'; then
                    sed -i "1s|/usr/bin/env|$(command -v env)|" "$f" 2>/dev/null || true
                  fi
                fi
              done
            fi
          '';
        };
      }
    );
}
