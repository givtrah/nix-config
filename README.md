# nix-config
Nixos files for my installations


# How to use
Make sure git and gh is installed

# Auth
gh auth login # login to github using ssh and auth token

# Tell git who you are
git config --global user.name "givtrah"

git config --global user.email "THESECRET@email.com"

mkdir ~/.dotfiles

cd ~/.dotfiles

git clone https://github.com/givtrah/nix-config

# add all (new) files
git add *

# push new commit
git commit -m "reason"

# Overall directory structure


# Nix os commands in dir

sudo nixos-rebuild boot --flake ./#taumac --impure

sudo nix flake update



**
