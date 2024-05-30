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
```
mkdir ~/.dotfiles
cd ~/.dotfiles
git clone git@github.com:givtrah/nix-config
```
or use https 
(note: Change git repo from https to ssh afterwards in git config!)
```
git clone https://github.com/givtrah/nix-config
```
# add all (new) files
```
git add .
```
# commit
```
git commit -m "reason"
```
# push
```
git push
```

# solve problems with repo being different from local
(by overwriting local with the repo)

```
git fetch --all
git reset --hard origin/main
git pull
```
If you feel you may use the local changes later you can do:

```
git stash
```
before doing the above fetch/reset/pull

then to reapply stashed changes later do:

```
git stash pop
```

# Overall directory structure


# Nix os commands in dir

Update system according to the flake and nix files
```
sudo nixos-rebuild boot --flake . --impure

(impure for now, asahi only works well with impure and I have other issues as well that requires impure for now until I solve the issues)
```

Update the flake file (e.g. actually do an update! run update system above afterwards)
```
sudo nix flake update

```


