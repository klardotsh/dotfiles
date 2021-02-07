{ config, pkgs, ... }:
{
  services.pcscd.enable = true;
  environment.systemPackages = [
    pkgs.libu2f-host
    pkgs.yubikey-manager
  ];
}

