# User Configuration Example
# Copy this file to config.nix and customize it
#
# cp config.example.nix config.nix
{
  # Your macOS username
  username = "your-username";

  # Enable/disable Laravel development environment
  # When true: installs PHP, Composer, MySQL, PostgreSQL, Redis
  # When false: skips Laravel-related packages and aliases
  enableLaravel = true;

  # SSH public keys for authorized_keys
  # Add your public keys here for SSH access
  sshKeys = [
    # "ssh-ed25519 AAAAC3Nza... user@example.com"
    # "ssh-rsa AAAAB3Nza... another@example.com"
  ];
}
