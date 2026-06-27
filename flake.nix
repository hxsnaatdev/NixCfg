{
  description = "nix-darwin flake for reproducible builds";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #macos utils
    hammerspoon.url = "path:/Users/ariz/.hammerspoon";
    Better-display = {
      url = "github:waydabber/BetterDisplay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    LiveMacos-Wallpaper = {
      url = "github:thusvill/LiveWallpaperMacOS";
      input.nixpkgs.follows = "nixpkgs";
    };

    #keyboard
    Kanata-Tray = {
      url = "github:rszyma/Kanata-Tray";
      input.nixpkgs.follows = "nixpkgs";
    };

    Kanata = {
      url = "github:jtroo/kanata";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    #tui
    leetcode-tui = {
      url = "github:akarsh1995/leetcode-tui";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = {
    nix-darwin,
    home-manager,
    ...
  }: let
    darwinSystem = nix-darwin.lib.darwinSystem {
      modules = [
        ./hosts/darwin.nix
        ./module/darwin/kanata-tray.nix
        ./module/darwin/kanata.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ariz = import ./home;
        }
      ];
    };
  in {
    darwinConfigurations."Hasnaats-MacBook-Air" = darwinSystem;
  };
}
