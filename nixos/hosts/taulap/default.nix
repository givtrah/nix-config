# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
      # load disko config to setup disks
      ./disko-config.nix
      ../../users.nix
      ../../features/locale_tz.nix
      ../../features/sound.nix
      ../../features/sddm.nix
      ../../features/plasma6.nix



    ];




  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # misc boot things
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # fix problems with two fingers needed for cursor movement
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];

  # increase watchable files (to stop dropbox from blinking...)
  boot.kernel.sysctl = { "fs.inotify.max_user_watches" = "1048576"; };

  networking.hostName = "taulap"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # fix non-nix programs not working (taken from https://nix.dev/guides/faq.html) 
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    # consider using "steam-run" to run non-nix programs
  ]; 

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  

  # Configure console keymap
#  console.keyMap = "dk-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # flatpak enable
  services.flatpak.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  nixpkgs.config.allowUnfree = true;

  # OPENGL

  hardware.opengl.enable = true;
  
  # Fix missing window decorations and terrible icon themes for gnome programs outside of gnome
  # also needs package gnome.adwaita-icon-theme

  programs.dconf.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  environment.systemPackages = with pkgs; [
  git # git must be first when using flakes as it clones its dependencies using git
  gh
  curl
  wget

  neovim # editor of choice
  dropbox
  firefox
  wget
  glxinfo
  mesa-demos
  libreoffice-qt
  hunspell
  hunspellDicts.da_DK
  hunspellDicts.en_US
  zotero
  zoom-us
  microsoft-edge
  teams-for-linux
  google-chrome
  google-fonts
  corefonts
  vistafonts
  vulkan-tools
  gnome.adwaita-icon-theme
  btop
  steam-run
  R
  rstudio
  cmake
  rPackages.tidyverse 
  rPackages.ggvenn
  rPackages.ggpubr
  rPackages.limma
  rPackages.KEGGREST
  rPackages.S4Vectors
  rPackages.GEOquery
  rPackages.mogene10sttranscriptcluster_db
  rPackages.mogene11sttranscriptcluster_db

];

  environment.variables.EDITOR = "nvim"; # default editor is neovim

  programs.bash.shellAliases = {
    vi = "nvim"; # the one editor!
    sudo="sudo "; # fix aliases not working using sudo - the space means carry over aliases
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

