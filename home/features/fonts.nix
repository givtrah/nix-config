{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [


  google-fonts
  corefonts
  vistafonts
#  nerdfonts
  nerd-fonts.jetbrains-mono

  ];


}
