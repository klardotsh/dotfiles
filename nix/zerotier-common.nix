{ config, pkgs, ... }:
{
  services.zerotierone.enable = true;
  services.zerotierone.joinNetworks = [
  ];
}
