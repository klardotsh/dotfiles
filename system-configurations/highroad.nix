let
  sources = import ../nix/sources.nix;
  wanport = "enp1s0f1";
  lanport = "enp1s0f0";
  lavaport = "enp3s0"; # realtek is lava
  lansubnet = "42";
  laniprange = "192.168.${lansubnet}.0/24";
  # there's not really a great way to do this in a dynamic environment, and
  # CenturyLink is *aggressive* about changing my public IP, so this is...
  # an iffy solution at best. hope for long uptimes!
  loopbackIPs = [ "75.172.17.41" ];
in
{ imports ? [ ] }:
{ config, pkgs, ... }:
with config; {
  imports = imports ++ [
    ../nix/global.nix

    ../nix/death-to-sudo.nix
    ../nix/nix-gc.nix
    ../nix/server-machines.nix
    #../nix/ssh-keys-only.nix
    ../nix/zerotier-common.nix
  ];

  services.openssh.enable = true;

  boot.loader.systemd-boot.enable = true;

  programs.mosh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  # and now, make a router! based largely on
  # https://francis.begyn.be/blog/nixos-home-router
  boot.kernel.sysctl = {
    # if you use ipv4, this is all you need
    "net.ipv4.ip_forward" = true;
    "net.ipv4.conf.all.forwarding" = true;

    # If you want to use it for ipv6
    "net.ipv6.conf.all.forwarding" = true;

    # source: https://github.com/mdlayher/homelab/blob/master/nixos/routnerr-2/configuration.nix#L52
    # By default, not automatically configure any IPv6 addresses.
    "net.ipv6.conf.all.accept_ra" = 0;
    "net.ipv6.conf.all.autoconf" = 0;
    "net.ipv6.conf.all.use_tempaddr" = 0;

    # On WAN, allow IPv6 autoconfiguration and tempory address use.
    "net.ipv6.conf.highroad.accept_ra" = 2;
    "net.ipv6.conf.highroad.autoconf" = 1;
  };

  networking = {
    hostName = "highroad";
    useDHCP = false;
    nameservers = [
      "127.0.0.1"
      "1.1.1.1"
      "8.8.8.8"
      "8.8.4.4"
    ];

    # Define VLANS
    vlans = {
      wan = {
        id = 201;
        interface = wanport;
      };
    };

    interfaces = {
      ${lavaport}.useDHCP = false;

      ${lanport} = {
        useDHCP = false;
        ipv4.addresses = [{
          address = "192.168.${lansubnet}.1";
          prefixLength = 24;
        }];
      };

      ${wanport}.useDHCP = false;
      wan.useDHCP = false;
    };
  };

  # We need to run a DHCP server.  Let’s also reserve some IP addresses.
  # Additionally, we can set which DNS servers to use, a domain to search in,
  # etc.
  services.dhcpd4 = {
    enable = true;
    interfaces = [ lanport ];
    machines = [
      { hostName = "antarctica"; ipAddress = "192.168.${lansubnet}.201"; ethernetAddress = "0c:9d:92:85:27:77"; }
      { hostName = "woods"; ipAddress = "192.168.${lansubnet}.202"; ethernetAddress = "d4:5d:64:51:27:1a"; }
    ];
    extraConfig =
      ''
        option domain-name-servers 192.168.${lansubnet}.1;
        option subnet-mask 255.255.255.0;
        option interface-mtu 1492;

        subnet 192.168.${lansubnet}.0 netmask 255.255.255.0 {
          option broadcast-address 192.168.${lansubnet}.255;
          option routers 192.168.${lansubnet}.1;
          interface ${lanport};
          range 192.168.${lansubnet}.50 192.168.${lansubnet}.200;
        }
      '';
  };

  # https://www.lafuente.me/posts/local-dns-and-web-server/
  services.coredns.enable = true;
  services.coredns.config = ''
    . {
      # Cloudflare and Google
      forward . 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4
      cache
    }

    local {
      template IN A  {
          answer "{{ .Name }} 0 IN A 127.0.0.1"
      }
    }
  '';

  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ lanport ];
      externalInterface = "ppp0";

      forwardPorts = [
        { sourcePort = 22; destination = "192.168.${lansubnet}.201:22"; inherit loopbackIPs; } # ssh
        { sourcePort = 2222; destination = "192.168.${lansubnet}.201:2222"; inherit loopbackIPs; } # gitea ssh
        { sourcePort = 80; destination = "192.168.${lansubnet}.201:80"; inherit loopbackIPs; } # http
        { sourcePort = 443; destination = "192.168.${lansubnet}.201:443"; inherit loopbackIPs; } # https
        { sourcePort = 4443; destination = "192.168.${lansubnet}.201:4443"; inherit loopbackIPs; } # matrix synapse
      ];
    };

    firewall = {
      enable = true;
      package = pkgs.iptables-nftables-compat;
      allowPing = false;
      autoLoadConntrackHelpers = true;
      trustedInterfaces = [ lanport lavaport ];
      allowedTCPPorts = [
        22
        80
        443
        2222
        4443
      ];
    };
  };

  # setup pppoe session
  services.pppd = {
    enable = true;
    peers = {
      clink = {
        # Autostart the PPPoE session on boot
        autostart = true;
        enable = true;
        config = ''
          plugin rp-pppoe.so wan

          # pppd supports multiple ways of entering credentials,
          # this is just 1 way
          name "REPLACEME"
          password "REPLACEME"

          persist
          maxfail 0
          holdoff 5

          noipdefault
          defaultroute
        '';
      };
    };
  };
}
