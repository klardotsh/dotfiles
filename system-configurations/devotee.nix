{ home-manager, nixos-hardware, imports ? [ ] }:
{ config, pkgs, ... }:
with config; {
  imports = imports ++ [
    (nixos-hardware + "/dell/xps/13-9370")

    ../nix/global.nix

    ../nix/death-to-sudo.nix
    (import ../nix/interactive-machines.nix { inherit home-manager; })
    ../nix/ssh-keys-only.nix
    ../nix/wifi-bt.nix
    ../nix/yubikey.nix
    ../nix/zerotier-common.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  boot.kernelPackages = pkgs.linuxPackages_5_10;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  networking.hostName = "devotee";

  programs.mosh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}
