{ config, lib, pkgs, nixpkgs, ...}: {

  home.packages = with pkgs; 

# Found rev for version 1.3.0 by doing git ls-remote https://github.com/jalvesaq/colorout

let 
  colorout = pkgs.rPackages.buildRPackage {
    name = "colorout";
    src = pkgs.fetchFromGitHub {
      owner = "jalvesaq";
      repo = "colorout";
      rev = "838488283bbc0dbbce0a716db48b90b1ac6ff857";
      sha256 = "j18mKqcIMS9ph9uJquweEMGJhmp5lsw7jko9nszBcUA=";
    };
  };

# let
  # Define your desired packages here
  myRPackages = with rPackages; [
    colorout
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
