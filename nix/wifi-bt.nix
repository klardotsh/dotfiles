{ config, pkgs, ... }:
{
  hardware.bluetooth.enable = true;
  networking.wireless.iwd.enable = true;
}
