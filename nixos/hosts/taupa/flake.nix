{

  description = "taupa flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }:
    let 
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      taupa = lib.nixosSystem {
        system = "x86_64-linux";
	modules = [ ./configuration.nix ];
      };
    };
  };
}

