{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [

  # browsers
  (wrapFirefox (firefox-unwrapped.override { pipewireSupport = true;}) {} ) # add pipewire support to firefox, needed for screen sharing under wayland
  microsoft-edge
  google-chrome
  librewolf
  chromium



  ];



}
