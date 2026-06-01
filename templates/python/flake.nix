{
  description = "Python Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python3
            python3Packages.pip
            python3Packages.virtualenv
            python3Packages.black
            python3Packages.isort
            python3Packages.pytest
          ];

          shellHook = ''
            echo "Python Development Environment"
            python --version
            
            # Setup virtualenv if it doesn't exist
            if [ ! -d ".venv" ]; then
              echo "Creating virtualenv..."
              python -m venv .venv
            fi
            
            # Activate virtual environment
            source .venv/bin/activate
            
            # Install requirements if they exist
            if [ -f "requirements.txt" ] && [ -s "requirements.txt" ]; then
              echo "Installing requirements..."
              pip install -r requirements.txt
            fi
          '';
        };
      }
    );
}
