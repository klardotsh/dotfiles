{ config, pkgs, ... }:
{
  services.chrony.enable = true;

  # Clean up packages after a while
  nix.gc = {
    automatic = true;
    dates = "weekly UTC";
  };
}
