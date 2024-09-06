# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "usb_storage" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5fd3bd5f-4c87-4ed9-981d-e711687623db";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=lzo" "noatime" ];
    };

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/ae987213-ec73-499a-aca6-069144b8b982";

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/5fd3bd5f-4c87-4ed9-981d-e711687623db";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=lzo" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/5fd3bd5f-4c87-4ed9-981d-e711687623db";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=lzo" "noatime" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/5fd3bd5f-4c87-4ed9-981d-e711687623db";
      fsType = "btrfs";
      options = [ "subvol=log" "compress=lzo" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/681F-1DF2";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}