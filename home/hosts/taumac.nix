{ config, pkgs,  ... }:

{
  home.username = "ohm";
  home.homeDirectory = "/home/ohm";


  imports = [

  ../common.nix

  ../features/r.nix
  ../features/office.nix

  ../features/browsers.nix
  ../features/cli-tools.nix
  ../features/fonts.nix

  ../features/desktop.nix
  ../features/qemu.nix

  ../features/term.nix

  ../features/gaming.nix


  ../features/dev.nix

  ];


  
  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
#  xresources.properties = {
#    "Xcursor.size" = 16;
#    "Xft.dpi" = 172;
#  };

  # STABLE PACKAGES
#  home.packages = (with pkgs-stable; [
#    zotero
#    btop
#    eza
#
#
#  ])

#  ++

  # Packages that should be installed to the user profile.
home.packages =  with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    
    maestral
    maestral-gui

#   zotero - no zotero in unstable for aarch64, only in 23.11, find out how to fix this!




  ];

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";
}
