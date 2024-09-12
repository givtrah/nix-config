{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [
#  libreoffice-fresh
  hunspell
  hunspellDicts.da_DK
  hunspellDicts.en_US

  pdfsam-basic

#  onlyoffice-bin_latest



  ]



  ++
   
    (if (pkgs.system == "aarch64-linux")
    then [ libreoffice ]
  else
    (if (pkgs.system == "x86_64-linux")
      then [ libreoffice-fresh onlyoffice-bin_latest ]
      else []));


















}
