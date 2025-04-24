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
      #      url = "github:tpwrules/nixos-apple-silicon";
       url = "github:oliverbestmann/nixos-apple-silicon";
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
    zotero-nix = {
      url = "github:camillemndn/zotero-nix";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, nixos-cosmic, apple-silicon, zotero-nix, ... }@inputs: 

    let
      specialArgs = { inherit inputs nixpkgs home-manager nix-flatpak nixos-cosmic zotero-nix; };
      
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
	  home-manager.extraSpecialArgs = { inherit inputs nixpkgs nixos-cosmic zotero-nix; };
	  home-manager.users.ohm.imports = [ 
	    nix-flatpak.homeManagerModules.nix-flatpak
	    ./home/common.nix
          ];
	}
      ];

    in {
    
    nixosConfigurations = {

      # Macbook Air M2 (16 GB / 512 GB) - Nix OS unstable
      taumac = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = specialArgs // { inherit apple-silicon; };
        modules =  shared-modules ++ [
	  ./hosts/taumac
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
	specialArgs = specialArgs;
	modules = shared-modules ++ [
	  ./hosts/taupa
	  nixos-cosmic.nixosModules.default
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
	specialArgs = specialArgs;
	modules = shared-modules ++ [
	 ./hosts/taude
	 home-manager.nixosModules.home-manager { 
	   home-manager.users.ohm = {
	     home.stateVersion = "24.11";
	     imports = [ ]; 
	 };
	}
	];
      };


      # Lenovo Laptop (16/2 TB) - Nix OS unstable
      taulap = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = specialArgs;
	modules = shared-modules ++ [
	 ./hosts/taulap
	 home-manager.nixosModules.home-manager { 
	   home-manager.users.ohm = {
	     home.stateVersion = "24.05";
	     imports = [ ]; 
	 };
	}
	];
      };

    };

  };
}




