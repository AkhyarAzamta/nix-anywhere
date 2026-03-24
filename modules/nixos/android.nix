{
  pkgs,
  username,
  ...
}:
let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "34" ];
    buildToolsVersions = [ "34.0.0" ];
    includeEmulator = true;
    includeSources = false;
    includeSystemImages = true;
    systemImageTypes = [ "google_apis" ];
    abiVersions = [ "x86_64" ];
    includeNDK = false;
    includeExtras = [ ];
  };
in
{
  # ADB + udev rules
  programs.adb.enable = true;

  # User groups for KVM and ADB access
  users.users.${username}.extraGroups = [
    "kvm"
    "adbusers"
  ];

  # Android SDK environment
  environment.systemPackages = [
    androidComposition.androidsdk
  ];

  # Environment variables
  environment.sessionVariables = {
    ANDROID_HOME = "${androidComposition.androidsdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
  };
}
