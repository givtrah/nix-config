{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [

    kdePackages.kcalc
    
    dropbox
    armcord


  jellyfin-media-player
  mesa-demos # includes everything in glxinfo
  zotero
  zoom-us
  teams-for-linux
  vulkan-tools
  gnome.adwaita-icon-theme
  steam-run 
  v4l-utils
  guvcview
  nerdfonts

  inkscape

  gsmartcontrol
  # productivity / work
  kitty
  kitty-themes
  kitty-img
  starship
  pywal

  zettlr
  remmina
  nomachine-client
#  libsForQt5.kcalc
#  libsForQt5.kate


  # Multimedia
  mpv
  vlc


  ];


}
