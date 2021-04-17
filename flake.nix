{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;
  inputs.home-manager.url = github:nix-community/home-manager/release-20.09;

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations.villain = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nix/nix.nix # lol
        ./system-configurations/villain-hardware.nix
        (import ./system-configurations/villain.nix {
          inherit home-manager;
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
