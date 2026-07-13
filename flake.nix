{
  description = "nix-darwin flake for reproducible builds";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    #keyboard
    Kanata-Tray = {
      url = "github:rszyma/Kanata-Tray";
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

  outputs = inputs @ {
    nix-darwin,
    home-manager,
    sops-nix,
    ...
  }: let
    darwinSystem = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/M4/darwin.nix
        ./module/home-managed/hammerspoon.nix
        ./module/home-managed/warpd.nix
        sops-nix.darwinModules.sops

        /*
        not using kanata and its menu bar tray rn , to hectic for me to re-engineer from inpirational repo's
        like :
        os-nixCfg
        daniel's -d rens
        and many others at oxalica
        # ./module/darwin/kanata-tray.nix
        #./module/darwin/kanata.nix
        */

        home-manager.darwinModules.home-manager
        ({config, ...}: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            syncthingGuiPasswordFile = config.sops.secrets."syncthing/guiPassword".path;
          };
          home-manager.users.ariz = import ./home/home-manager.nix;
        })
      ];
    };
  in {
    darwinConfigurations."Hasnaats-MacBook-Air" = darwinSystem;
  };
}
