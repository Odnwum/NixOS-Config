{
  description = "balls";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nfv
    nvf = {
      url = "github:notashelf/nvf";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

  };

  outputs =
    {
      self,
      nixpkgs,
      nvf,
      zen-browser,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

    in
    {
      nixosConfigurations = {
        chungie = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit zen-browser;
          };
          modules = [
            ./configuration.nix
            inputs.home-manager.nixosModules.default
            nvf.nixosModules.default
          ];
        };
      };
    };
}
