{ config, pkgs, ...}: {

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "givtrah";
    userEmail = "givtrah@givtrah.org";
  };


  home.packages = with pkgs; 

  [


  ];



}
