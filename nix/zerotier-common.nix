{ config, pkgs, ... }:
{
  # bsl license requires this
  nixpkgs.config.allowUnfree = true;

  services.zerotierone.enable = true;
  services.zerotierone.joinNetworks = [
  ];
}
