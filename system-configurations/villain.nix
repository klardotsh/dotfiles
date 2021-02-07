let
  sources = import ../nix/sources.nix;
in
{ imports }:
{ config, pkgs, ... }:
with config; {
  imports = imports ++ [
    # TODO write a nixos-hardware module for c630
    # (sources.nixos-hardware + "/dell/xps/13-9370")

    ../nix/death-to-sudo.nix
    ../nix/interactive-machines.nix
    ../nix/ssh-keys-only.nix
    ../nix/wifi-bt.nix
    ../nix/yubikey.nix
    ../nix/zerotier-common.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      # pretty sure freedreno doesn't support the ARM accelerators yet?
    ];
  };

  programs.mosh.enable = true;
}
