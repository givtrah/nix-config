# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
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

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # 2060 super passthrough
#  gpuIDs = [
#    "10de:1f06" # Graphics
#    "10de:10f9" # Audio
#    "10de:1ada" # USB controller
#    "10de:1adb" # Serial bus controller
#  ];

  # early modules
  boot.initrd.kernelModules = [ "vfio" "vfio_pci" "vfio_iommu_type1" ];
  # passthrough 2060 super
  boot.extraModprobeConfig ="options vfio-pci ids=10de:1f06,10de:10f9,10de:1ada,10de:1adb";
  # Enable KVM
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  
  # setup the ivshmem tmp file for looking glass
  systemd.tmpfiles.rules = [
  "f /dev/shm/looking-glass 0660 ohm qemu-libvirtd -"
  ];


  # Enable hugepages for better (windows) VM performance
  boot.kernelParams = ["hugepagesz=1G" "hugepages=24"]; # remember to enable in libvirt... 


  # mount additional drives (that I created myself)
   fileSystems."/mnt/vm" = {
   device = "/dev/disk/by-uuid/3a3992dd-78d2-4991-bb4d-dee2d36831bf";
   fsType = "btrfs";
   options = [ # If you don't have this options attribute, it'll default to "defaults" 
     # boot options for fstab. Search up fstab mount options you can use
     "noatime" # performance 
     "compress=zstd:3" # best performance from normal ssd
     "users" # Allows any user to mount and unmount
     "nofail" # Prevent system from failing if this drive doesn't mount
   ];
 };


# nixpkgs.config.permittedInsecurePackages = [
#               # "mailspring-1.12.0"
#              ];


  # Enable periodic scrub on btrfs (default once per month) as well as periodic trim (default once per week)

  services.btrfs.autoScrub.enable = true;
  services.fstrim.enable = true;

  networking.hostName = "taupa"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # tailscale
  services.tailscale.enable = true;
  
  # fix non-nix programs not working (taken from https://nix.dev/guides/faq.html) 
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    # consider using "steam-run" to run non-nix programs
  ]; 



  # Enable qtile
#  services.xserver.windowManager.qtile.enable = true;

  # Enable hyprland

  # Enable CUPS, ipp-usb and avahi to print documents (CUPS may not be necessary!).


  services.printing.enable = true;
  services.ipp-usb.enable = true;
  services.avahi.enable = true;

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };



  # flatpak enable
  services.flatpak.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;



  # OPENGL

  hardware.opengl.enable = true;

  # Fix missing window decorations and terrible icon themes for gnome programs outside of gnome
  # also needs package gnome.adwaita-icon-theme

  programs.dconf.enable = true;



  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # allowed users (allowed to interact with nix daemon, this may be the default setting)
  nix.settings.allowed-users = [ "*" ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Make bash default shell for all
  users.defaultUserShell = pkgs.bash;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;

  let
    RStudio-with-my-packages = rstudioWrapper.override{
      packages = with rPackages; [ 
        tidyverse
	pastecs
	jtools
	huxtable
	officer
	tableone
	data_table
	HDF5Array
	]; };
  in



  [
  git # git must be first when using flakes as it clones its dependencies using git
  gh
  curl
  wget
  jellyfin-media-player
  neovim # editor of choice
  dropbox
  mesa-demos # includes everything in glxinfo
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
  tmux
  v4l-utils
  guvcview
  usbutils
  nerdfonts

  inkscape

  smartmontools
  gsmartcontrol
  # productivity / work
  kitty
  kitty-themes
  kitty-img
  starship
  pywal

  pdfsam-basic
  zettlr
  remmina
  RStudio-with-my-packages
  nomachine-client
  libsForQt5.kcalc
  libsForQt5.kate

  # browsers
  (wrapFirefox (firefox-unwrapped.override { pipewireSupport = true;}) {} ) # add pipewire support to firefox, needed for screen sharing under wayland
  microsoft-edge
  google-chrome
  librewolf

  # Network
  
  tailscale # FW passthrough
  autossh # FW passthrough


  # System tools
  dmidecode # for hardware information
  inxi # for hardware information
  lm_sensors # temps


  # for printing
  libusb1

  #
  virtiofsd

  # Swayfx
  swayfx
  swayr
  swayws
  swaybg
  swayosd
  swayimg
  swaycwd
  swayrbar
  swaylock
  swaykbdd
  swayidle
  swaycons
  swaytools
  swaysettings
  swaynotificationcenter
  waybar
  wofi
  wayshot
  autotiling
  rofi-wayland

  pciutils # for lspci
  OVMF # for qemu secure boot emulation
  looking-glass-client # for windows VM
  swtpm
  sunshine # remote desktop server (moonshine is client)
  moonlight-qt # remote desktop client
  ];

  # firefox




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

  # Virt-manager and Qemu - remember ovmf package for fake secure boot
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
	packages = [(pkgs.OVMF.override {
	  secureBoot = true;
	  tpmSupport = true;
	  }).fd];
	};
      };
    };
  programs.virt-manager.enable = true;



  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

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

