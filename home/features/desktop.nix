{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [

    kdePackages.kcalc
    
    armcord

  obsidian
  jellyfin-media-player
  mesa-demos # includes everything in glxinfo
#  zoom-us
#  teams-for-linux
  vulkan-tools
  gnome.adwaita-icon-theme
#  steam-run 
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

#  zettlr
  remmina
#  nomachine-client
#  libsForQt5.kcalc
#  libsForQt5.kate


  # Multimedia
  mpv
  vlc


  ]

 ++
  # packages not available on aarch64 goes here 
    (if (pkgs.system == "aarch64-linux")
    then [ ]
  else
    (if (pkgs.system == "x86_64-linux")
      then [ dropbox zotero teams-for-linux zoom-us steam-run nomachine-client zettlr ]
      else []));



}
