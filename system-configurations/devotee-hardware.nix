{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "aes_x86_64"
    "aesni_intel"
    "cryptd"
    "nvme"
    "rtsx_pci_sdmmc"
    "xhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/88b7d10c-c752-405a-adee-d53b5c5d1d23";
    fsType = "f2fs";
  };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/0ae26360-5275-4608-95f3-f7417fc89508";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0F95-C875";
    fsType = "vfat";
  };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
