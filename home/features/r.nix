{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  let
    R-with-my-packages = rWrapper.override{
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
    R-with-my-packages







  ];






















}
