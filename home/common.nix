{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [
  jellyfin-media-player
  neovim # editor of choice
#  dropbox - beware, only maestral works on aarch64
  mesa-demos # includes everything in glxinfo
  # zotero
  # zoom-us
  # microsoft-edge
  # teams-for-linux
  google-fonts
  corefonts
  vistafonts
  vulkan-tools
  gnome.adwaita-icon-theme
  btop
#  steam-run 
  tmux
  v4l-utils
  guvcview
  usbutils
  nerdfonts

  smartmontools
  gsmartcontrol
  # productivity / work
  kitty
  kitty-themes
  kitty-img
  starship
  pywal

#  zettlr
  remmina
#  nomachine-client
#  libsForQt5.kcalc
#  libsForQt5.kate

  # browsers
  (wrapFirefox (firefox-unwrapped.override { pipewireSupport = true;}) {} ) # add pipewire support to firefox, needed for screen sharing under wayland
#  microsoft-edge
#  google-chrome
  librewolf

  # Network
  
  tailscale # FW passthrough
  autossh # FW passthrough
  
  gcc13

  # System tools
  dmidecode # for hardware information
  inxi # for hardware information
  lm_sensors # temps


  # for printing
  libusb1

  # QEMU
#  virtiofsd
#  pciutils # for lspci
#  OVMF # for qemu secure boot emulation
#  looking-glass-client # for windows VM
#  swtpm





  ];






















}
