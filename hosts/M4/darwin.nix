{pkgs, ...}: {
  imports = [
    ./defaults/defaultPrefs.nix
    ./kanata-launchd.nix
  ];
  nix.enable = false;
  nix.settings.auto-optimise-store = true;

  environment.systemPackages = with pkgs; [
    kanata
    betterdisplay
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = "ariz";

  sops = {
    defaultSopsFile = ../../secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/Users/ariz/.config/sops/age/keys.txt";

    secrets."syncthing/guiPassword" = {
      owner = "ariz";
      mode = "0400";
    };
  };

  system.stateVersion = 6;
}
