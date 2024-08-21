{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [

  # browsers
  (wrapFirefox (firefox-unwrapped.override { pipewireSupport = true;}) {} ) # add pipewire support to firefox, needed for screen sharing under wayland
  librewolf
  chromium


  (wrapFloorp (floorp-unwrapped.override { pipewireSupport = true;}) {} ) # add pipewire support to floorp, needed for screen sharing under wayland
  librewolf

  ]

  ++
   
    (if (pkgs.system == "aarch64-linux")
    then [ ]
  else
    (if (pkgs.system == "x86_64-linux")
      then [ microsoft-edge google-chrome ]
      else []));

}
