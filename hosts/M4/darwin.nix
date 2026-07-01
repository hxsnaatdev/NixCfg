{pkgs, ...}: {
  imports = [
    ./defaults/defaultPrefs.nix
    ./kanata-launchd.nix
  ];
  nix.enable = false;
  nix.settings.auto-optimise-store = true;

  environment.systemPackages = with pkgs; [
    Kanata
    BetterDisplay
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = "ariz";

  system.stateVersion = 6;
}
