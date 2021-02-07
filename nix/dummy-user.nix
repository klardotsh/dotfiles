{ config, pkgs, ... }:
{
  # I need a dummy user (to jump to j and/or root) for QEMU use only - this
  # should never be imported on a production system!
  users.users.dummy = {
    password = "";
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };
}
