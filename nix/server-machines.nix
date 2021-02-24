let
  sources = import ../nix/sources.nix;
in
{ config, pkgs, ... }:
{
  imports = [
    (sources.home-manager + "/nixos")
  ];

  nixpkgs.overlays = [
    (self: super: {
    })
  ];

  time.timeZone = "UTC";
  nix.trustedUsers = [ "@wheel" ];

  environment.systemPackages = [
    pkgs.home-manager
    pkgs.htop
  ];

  users.users.operator = {
    isNormalUser = true;
    extraGroups = [
      "kvm"
      "storage"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [ (builtins.readFile ../klardotsh.id_rsa.pub) ];
  };

  home-manager.useGlobalPkgs = true;
  # home-manager.users.operator = import ../nix/user-j.nix;
}
