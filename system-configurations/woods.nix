let
  sources = import ../nix/sources.nix;
in
{ imports ? [ ] }:
{ config, pkgs, ... }:
with config; {
  imports = imports ++ [
    ../nix/global.nix

    ../nix/death-to-sudo.nix
    ../nix/interactive-machines.nix
    ../nix/ssh-keys-only.nix
    ../nix/wifi-bt.nix
    ../nix/yubikey.nix
    ../nix/zerotier-common.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  boot.kernelPackages = pkgs.linuxPackages_5_10;
  boot.supportedFilesystems = [ "zfs" ];

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  networking.hostId = "739c0e1c";
  networking.hostName = "woods";
  networking.useDHCP = true;

  programs.mosh.enable = true;

  services.zfs = {
    autoScrub.enable = true;
    autoSnapshot = {
      enable = true;
      frequent = 8; # keep the latest eight 15-minute snapshots (instead of four)
      monthly = 1; # keep only one monthly snapshot (instead of twelve)
    };
  };

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
