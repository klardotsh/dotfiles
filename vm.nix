let
  sources = import ./nix/sources.nix;
  nixpkgs-nixos = import (sources.nixpkgs + "/nixos");

  antarctica = (nixpkgs-nixos {
    system = "x86_64-linux";
    configuration = import ./system-configurations/antarctica.nix {
      imports = [
        ./nix/disable-qemu-gfx.nix
        ./nix/dummy-user.nix
      ];
    };
  }).vm;

  devotee = (nixpkgs-nixos {
    system = "x86_64-linux";
    configuration = import ./system-configurations/devotee.nix {
      imports = [
        ./nix/disable-qemu-gfx.nix
        ./nix/dummy-user.nix
      ];
    };
  }).vm;

  devotee-gui = (nixpkgs-nixos {
    system = "x86_64-linux";
    configuration = import ./system-configurations/devotee.nix {
      imports = [
        ./nix/dummy-user.nix
      ];
    };
  }).vm;

  highroad = (nixpkgs-nixos {
    system = "x86_64-linux";
    configuration = import ./system-configurations/highroad.nix {
      imports = [
        ./nix/disable-qemu-gfx.nix
        ./nix/dummy-user.nix
      ];
    };
  }).vm;

  villain = (nixpkgs-nixos {
    system = "aarch64-linux";
    configuration = import ./system-configurations/villain.nix {
      imports = [
        ./nix/disable-qemu-gfx.nix
        ./nix/dummy-user.nix
      ];
    };
  }).vm;

  villain-gui = (nixpkgs-nixos {
    system = "aarch64-linux";
    configuration = import ./system-configurations/villain.nix {
      imports = [
        ./nix/dummy-user.nix
      ];
    };
  }).vm;
in
{
  inherit antarctica;
  inherit devotee;
  inherit devotee-gui;
  inherit highroad;
  inherit villain;
  inherit villain-gui;
}
