{ config, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "nvme"
    "sd_mod"
    "usb_storage"
    "xhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.loader.grub = {
    # quoth https://nixos.wiki/wiki/NixOS_on_ZFS (24 Feb 2021)
    # Using NixOS on a ZFS root file system might result in the boot error
    # external pointer tables not supported when the number of hardlinks in the
    # nix store gets very high. This can be avoided by adding this option to
    # your configuration.nix file:
    copyKernels = true;
    device = "nodev";
    efiInstallAsRemovable = true;
    efiSupport = true;
  };


  fileSystems."/" =
    { device = "EVO970/root/nixos";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/21DE-BFBB";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    { device = "EVO970/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "EVO970/home";
      fsType = "zfs";
    };

  swapDevices = [ ];
}
