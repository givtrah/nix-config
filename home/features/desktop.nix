{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [

    amarok
    asunder # cd ripper
    lame

    amdgpu_top
    lact
    piper

    gnome-multi-writer


    qbittorrent-qt5

    telegram-desktop
    kdePackages.kcalc
    
    armcord
    calibre
  obsidian
  jellyfin-media-player
  mesa-demos # includes everything in glxinfo
#  zoom-us
#  teams-for-linux
  vulkan-tools
  adwaita-icon-theme
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
#  libsForQt5.kcalc
#  libsForQt5.kate


  # Multimedia
  mpv
  vlc


  ]

 ++
  # packages not available on aarch64 goes here 
    (if (pkgs.system == "aarch64-linux")
    then [ maestral maestral-gui ]
  else
    (if (pkgs.system == "x86_64-linux")
      then [ dropbox zotero zoom-us steam-run zettlr nomachine-client ]
      else []));

# teams-for-linux

}
