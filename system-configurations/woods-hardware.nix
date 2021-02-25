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
