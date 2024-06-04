# Garbage collection:

https://nix.dev/manual/nix/2.18/package-management/profiles

https://nixos.wiki/wiki/Storage_optimization



# List generations 
sudo nix-env -p /nix/var/nix/profiles/system --list-generations

# delete generations older than 7d
sudo nix-collect-garbage --delete-older-than 7d






