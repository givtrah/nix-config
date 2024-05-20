{
  description = "Givtrah nix config because I'm a special snowflake";

  inputs = {
   
    # Unstable nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";
    
    # Yuzu
    nixpkgs-yuzu.url = "github:nixos/nixpkgs/95002f7";

    # Home-manager 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  
  outputs = inputs@{ 
    self,
    nixpkgs, 
    home-manager, 
    apple-silicon,
    nixos-cosmic, 
    ... 
    
    }: 

#      let
#        pkgs = nixpkgs.legacyPackages.aarch64-linux;
#        pkgs-stable = nixpkgs-stable.legacyPackages.aarch64-linux;
#        pkgs-cosmic = nixos-cosmic.legacyPackages.aarch64-linux;
#      in
    {

    nixosConfigurations = {
      nixpkgs.config.allowUnfree = true;
      # Macbook Air M2 (16/512) - Nix OS unstable

      taumac = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs; inherit nixpkgs; inherit home-manager; inherit apple-silicon; inherit nixos-cosmic;};
        modules = [


#          {
#            nix.settings = {
#              substituters = [ "https://cosmic.cachix.org/" ];
#              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
#            };
 #         }

          ./nixos/hosts/taumac
	  inputs.apple-silicon.nixosModules.apple-silicon-support
#          { nix.settings = {
#              substituters = [ "https://cosmic.cachix.org/" ];
#              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
#            };
#          }

          nixos-cosmic.nixosModules.default

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ohm = import ./home/hosts/taumac.nix;
	    home-manager.extraSpecialArgs = {inherit inputs; inherit nixpkgs; inherit nixos-cosmic; };
          }
        ]; 
      };
      
      # Lenovo Laptop (16/2 TB) - Nix OS stable (23.11)
#      taulap = nixpkgs.lib.nixosSystem {
#        system = "x86_64-linux";
#        specialArgs = {inherit inputs;};
#        modules = [
#          ./nixos/hosts/taulap
#          home-manager.nixosModules.home-manager
#        ];
#      };
    };

  };
}




