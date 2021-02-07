let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in
pkgs.mkShell {
  buildInputs = [
    pkgs.bashInteractive

    pkgs.cachix
    pkgs.niv
    pkgs.nixpkgs-fmt
    pkgs.rnix-lsp

    pkgs.git
    pkgs.git-lfs
  ];

  # https://github.com/NixOS/nixpkgs/issues/3382
  GIT_SSL_CAINFO = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
}
