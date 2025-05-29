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
    };

    outputs = {self, nixpkgs, nvf, ...} @inputs: 
        let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
                inherit system;
                config = {
                    allowUnfree = true;
                };
        };

        in {
            nixosConfigurations = {
                chungie = nixpkgs.lib.nixosSystem {
                    specialArgs = {inherit (inputs);};
        	    modules = [
			./configuration.nix
			inputs.home-manager.nixosModules.default
			nvf.nixosModules.default
                    ];
                };
            };
        };
}
