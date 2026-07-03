{
  description = "nix-darwin flake for reproducible builds";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

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
    ...
  }: let
    darwinSystem = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/M4/darwin.nix

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
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.ariz = import ./home/home-manager.nix;
        }
      ];
    };
  in {
    darwinConfigurations."Hasnaats-MacBook-Air" = darwinSystem;
  };
}
