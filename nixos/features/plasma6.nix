{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";


}
