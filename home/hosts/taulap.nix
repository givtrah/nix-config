{ config, pkgs,  ... }:

{
  home.username = "ohm";
  home.homeDirectory = "/home/ohm";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [

  ../features/r.nix
  ../features/office.nix
  ../common.nix

  ../features/browsers.nix
  ../features/cli-tools.nix
  ../features/fonts.nix

  ../features/desktop.nix
  ../features/qemu.nix
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
    



  ];

#  # basic configuration of git, please change to your own
#  programs.git = {
#    enable = true;
#    userName = "givtrah";
#    userEmail = "givtrah@givtrah.org";
#  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

}
