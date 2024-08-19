{ config, pkgs, ...}: {

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "givtrah";
    userEmail = "givtrah@givtrah.org";
  };



#  programs.dconf.enable = true; Should be done in a module

# Use `dconf watch /` to track stateful changes you are doing, then set them here.


  dconf.settings."org/gtk/settings/file-chooser" = {
    sort-directories-first = true;
  };

  home.packages = with pkgs; 

  [

  ];



}
