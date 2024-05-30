# nix-config
Nixos files for my installations

# How to use
Make sure git and gh is installed

# Auth
```
gh auth login # login to github using ssh and auth token
```

# Tell git who you are
```
git config --global user.name "givtrah"

git config --global user.email "THESECRET@email.com"
```

# Clone repo
mkdir ~/.dotfiles
cd ~/.dotfiles

git clone git@github.com:givtrah/nix-config

or (don't do this, use the above! or you have to change git repo from https to ssh later...):
git clone https://github.com/givtrah/nix-config

# add all (new) files
git add .

# commit
git commit -m "reason"

# push
git push

# solve problems with repo being different from local
(by overwriting local with the repo)

git fetch --all
git reset --hard origin/main
git pull

If you feel you may use the local changes later you can do:

git stash

before doing the above fetch/reset/pull

then to reapply stashed changes later do:

git stash pop

# Overall directory structure


# Nix os commands in dir

sudo nixos-rebuild boot --flake ./#taumac --impure

sudo nix flake update



**
