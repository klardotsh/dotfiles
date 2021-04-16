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

    (import sources.neovim-nightly-overlay)
  ];

  time.timeZone = "America/Los_Angeles";
  nix.trustedUsers = [ "@wheel" ];

  environment.systemPackages = [
    pkgs.home-manager
    pkgs.htop
    pkgs.killall
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
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.j = import ../nix/user-j.nix;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  nixpkgs.config.pulseaudio = true;
  services.pipewire = {
    enable = true;
    #alsa = {
    #  enable = true;
    #  support32Bit = true;
    #};
    #pulse.enable = true;
    #jack.enable = true;
  };
  nixpkgs.config.pipewire = true;

  # preemptively fix a bunch of stuff here since user-j will pull in a ton of
  # GTK stuff
  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = ["Iosevka"];
      };
    };
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      font-awesome
      noto-fonts
      iosevka
      paratype-pt-sans
      paratype-pt-serif
      twitter-color-emoji
      twemoji-color-font
    ];
  };
}
