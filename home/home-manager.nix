{lib, ...}: {
  imports = [
    ../module/home-managed/hammerspoon.nix
    ../module/home-managed/warpd.nix
    ./dev/git.nix
    ./tty/shells/fish.nix
    ./tty/starship.nix
    ./syncthing.nix
  ];
  home.username = "ariz";
  home.homeDirectory = lib.mkForce "/Users/ariz";
  home.stateVersion = "26.05";
  home.enableNixpkgsReleaseCheck = false;
  home.file.".hushlogin".text = "";

  programs.home-manager.enable = true;
  programs.warpd.enable = true;
  programs.warpd.package = null;
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };
}
