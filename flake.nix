{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;
  inputs.home-manager.url = github:nix-community/home-manager/release-20.09;
  inputs.nixos-hardware.url = github:NixOS/nixos-hardware/master;

  outputs = { self, nixpkgs, home-manager, nixos-hardware }: {
    nixosConfigurations.devotee = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nix/nix.nix # lol
        ./system-configurations/devotee-hardware.nix
        (import ./system-configurations/devotee.nix {
          inherit home-manager;
          inherit nixos-hardware;
        })
      ];
    };

    nixosConfigurations.woods = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nix/nix.nix # lol
        ./system-configurations/woods-hardware.nix
        (import ./system-configurations/woods.nix {
          inherit home-manager;
        })
      ];
    };
  };
}
