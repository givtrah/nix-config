{ config, lib, pkgs, nixpkgs, ...}: {

  home.packages = with pkgs; 



let
  # Define your desired packages here
  myRPackages = with rPackages; [
    tidyverse
    pastecs
    jtools
    huxtable
    officer
    tableone
    data_table
    HDF5Array
    ggvenn
    ggpubr
    limma
    KEGGREST
    S4Vectors
    GEOquery
    mogene10sttranscriptcluster_db
    mogene11sttranscriptcluster_db

  ];

  R-with-my-packages = rWrapper.override {
    packages = myRPackages;
  };

  RStudio-with-my-packages = rstudioWrapper.override {
    packages = myRPackages;
  };

  in

  # Conditionally include RStudio-with-my-packages based on the architecture


  [ R-with-my-packages ] ++
   
    (if (pkgs.system == "aarch64-linux")
    then [ ]
  else
    (if (pkgs.system == "x86_64-linux")
      then [ RStudio-with-my-packages ]
      else []));


}
