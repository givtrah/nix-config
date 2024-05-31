{ config, lib, pkgs, ... }:

{
  

  # Options considered always enabled regardless of host

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flatpaks
  services.flatpak.enable = true;
  
  # Enable OpenGL
  hardware.opengl.enable = true;

  # Enable experimental nix commands and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Fix missing window decorations and terrible icon themes for gnome programs outside of gnome
  # also needs package gnome.adwaita-icon-theme

  programs.dconf.enable = true;



  environment.variables.EDITOR = "nvim"; # default editor is neovim

  # Make BASH the default user shell
  users.defaultUserShell = pkgs.bash;

  programs.bash.shellAliases = {
    vi = "nvim"; # the one editor!
    sudo="sudo "; # fix aliases not working using sudo - the space means carry over aliases
  };




  # Packages ALL systems should ALWAYS have installed, to be used for ALL users (users + root)

  environment.systemPackages = with pkgs; [
  git # git must be first when using flakes as it clones its dependencies using git
  gh
  curl
  wget

  neovim
  vim






  gnome.adwaita-icon-theme # for dconf enable above, fix gnome window decorations



  cmake



  ];



}
