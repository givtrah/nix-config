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

      ../../features/common.nix

      ../../users.nix
      ../../features/locale_tz.nix
      ../../features/sound.nix
      ../../features/sddm.nix
      ../../features/plasma6.nix
      ../../features/flatpak.nix

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


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment? (NEVER CHANGE!)

}

