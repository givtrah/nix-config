{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [
    

  virtiofsd

  OVMF # for qemu secure boot emulation
  looking-glass-client # for windows VM
  swtpm # software TPM






  ];


}
