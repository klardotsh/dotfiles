{ config, lib, pkgs, ... }:
{
  imports = [
    (import ./system-configurations/${KLARDOTSH_HOSTNAME}.nix {})
    ./system-configurations/${KLARDOTSH_HOSTNAME}-hardware.nix
  ];
}
