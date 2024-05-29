{ pkgs, ... }:
{
  # disable default sound module. see https://nixos.wiki/wiki/PipeWire

  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "chili";
  };

  environment.systemPackages = with pkgs;
    [
    sddm-chili-theme
    ];




  # Modify the SDDM theme to chili by getting it directly from github (todo: use the sddm-chili-theme which is a nix pkg)
#  services.displayManager.sddm.theme = "${(pkgs.fetchFromGitHub {
#      owner = "MarianArlt";
#      repo = "kde-plasma-chili";
#      rev = "a371123959676f608f01421398f7400a2f01ae06";
#      sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
#  })}";


}
