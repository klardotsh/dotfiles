let
  sources = import ../nix/sources.nix;
in
{ config, pkgs, ... }:
{
  imports = [
    (sources.home-manager + "/nixos")
  ];

  # let's just be real, no machines a mere mortal would sit at and use these
  # days can run without unfree software
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (self: super: {
    })
  ];

  time.timeZone = "America/Los_Angeles";
  nix.trustedUsers = [ "@wheel" ];

  environment.systemPackages = [
    pkgs.home-manager
    pkgs.htop
  ];

  networking.firewall.allowedTCPPorts = [
    22
  ];

  users.users.j = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "kvm"
      "storage"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [ (builtins.readFile ../klardotsh.id_rsa.pub) ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.j = import ../nix/user-j.nix;

  # https://nixos.wiki/wiki/PulseAudio
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  # since the alsa plugin is useful and the BT module is I believe also trimmed
  # from the stock package, and since disk space is cheap...
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    gtkUsePortal = true;
  };
}
