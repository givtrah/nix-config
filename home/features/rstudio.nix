{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  let
    RStudio-with-my-packages = rstudioWrapper.override{
      packages = with rPackages; [ 
        tidyverse
        pastecs
        jtools
        huxtable
        officer
        tableone
        data_table
        HDF5Array
        ]; };
  in



  [
    RStudio-with-my-packages







  ];










}
