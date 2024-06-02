{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [
  libreoffice-qt
  hunspell
  hunspellDicts.da_DK
  hunspellDicts.en_US

  pdfsam-basic

  onlyoffice-bin_latest



  ];






















}
