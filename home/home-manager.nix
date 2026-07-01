{...}: {
  imports = [
    ../module/home-managed/hammerspoon.nix
    ../module/home-managed/warpd.nix
    ./dev/git.nix
    ./tty/shells/fish.nix
    ./tty/starship.nix
  ];
  home.username = "ariz";
  home.homeDirectory = "/Users/ariz";
  home.stateVersion = "26.05";
  home.enableNixpkgsReleaseChecks = false;
  home.file.".hushlogin".text = "";

  programs.home-manager.enable = true;
  programs.warpd.enable = true;
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.starship = {
    enable = true;
    configPath = "/Users/ariz/.config/starship.toml";
  };
}
