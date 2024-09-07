{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [
  libreoffice-qt-fresh
  hunspell
  hunspellDicts.da_DK
  hunspellDicts.en_US

  pdfsam-basic

#  onlyoffice-bin_latest



  ]



  ++
   
    (if (pkgs.system == "aarch64-linux")
    then [ ]
  else
    (if (pkgs.system == "x86_64-linux")
      then [ onlyoffice-bin_latest ]
      else []));


















}
