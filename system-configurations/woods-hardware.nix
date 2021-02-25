{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "sd_mod"
    "usb_storage"
    "xhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.loader.efi.canTouchEfiVariables = true;

  # quoth https://nixos.wiki/wiki/NixOS_on_ZFS (24 Feb 2021)
  # Using NixOS on a ZFS root file system might result in the boot error
  # external pointer tables not supported when the number of hardlinks in the
  # nix store gets very high. This can be avoided by adding this option to your
  # configuration.nix file:
  boot.loader.grub.copyKernels = true;

  boot.loader.grub.devices = [ "ata-Samsung_SSD_850_EVO_500GB_S2RANX0J146020F" ];

  fileSystems."/" = {
    device = "woods850EVO/root/nixos";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "woods850EVO/home";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "woods850EVO/nix";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1E21-1789";
    fsType = "vfat";
  };

  swapDevices = [ ];
}
