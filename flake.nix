{
  description = "Givtrah nix config because I'm a special snowflake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; # unstable nixpkgs
    nixpkgs-yuzu.url = "github:nixos/nixpkgs/95002f7"; # yuzu (have to be tested...)
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
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?";
#      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, nixos-cosmic, apple-silicon, ... }@inputs: 
      let
        shared-modules = [
          {
	    nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ]; # nixos-cosmic build repo
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
	    home-manager.extraSpecialArgs = { inherit inputs nixpkgs nixos-cosmic; };
	    home-manager.users.ohm.imports = [ 
	     nix-flatpak.homeManagerModules.nix-flatpak
	     ./home/common.nix
        ];
	}
      ];

    in {
    nixosConfigurations = {
      nixpkgs.config.allowUnfree = true;

      # Macbook Air M2 (16 GB / 512 GB) - Nix OS unstable
      taumac = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs; inherit nixpkgs; inherit home-manager; inherit apple-silicon; inherit nixos-cosmic; };
        modules =  shared-modules ++ [
	  ./nixos/hosts/taumac
	  inputs.apple-silicon.nixosModules.apple-silicon-support
          home-manager.nixosModules.home-manager {
	    home-manager.users.ohm = {
	      home.stateVersion = "24.05";
	      imports = [ ];
	    };
	  }
	]; 
      };
      
      # Main desktop @ uni 5700x 64 GB multi-GPU, 2 TB nvme - Nix OS unstable
      taupa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = { inherit inputs; inherit nixpkgs; inherit home-manager; inherit nix-flatpak;};
	modules = shared-modules ++ [
	  ./nixos/hosts/taupa
	  home-manager.nixosModules.home-manager { 
	    home-manager.users.ohm = {
	      home.stateVersion = "24.05";
	      imports = [ ]; 
	  };
	}
	];
      };

      # Main desktop @ home 7900 64 GB multi-GPU, lots of NVME / SSD
      taude = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = { inherit inputs; inherit nixpkgs; inherit home-manager; inherit nix-flatpak; inherit nixos-cosmic;};
	modules = [

  	  {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }

	  ./nixos/hosts/taude
	  
          nixos-cosmic.nixosModules.default
	  
	  home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            
	    home-manager.users."ohm".imports = [ nix-flatpak.homeManagerModules.nix-flatpak 
	      ./home/hosts/taude.nix
	    ];

#	    home-manager.users.ohm = import ./home/hosts/taude.nix;
	    home-manager.extraSpecialArgs = {inherit inputs; inherit nixpkgs; inherit nixos-cosmic;};
	  }
	];
      };





      # Lenovo Laptop (16/2 TB) - Nix OS unstable
      taulap = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./nixos/hosts/taulap
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.ohm = import ./home/hosts/taulap.nix;
            home-manager.extraSpecialArgs = {inherit inputs; inherit nixpkgs; };
          }
        ];
      };
    };

  };
}




