{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";


}
