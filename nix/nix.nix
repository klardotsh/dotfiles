{ pkgs, nix, ... }: {
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Clean up packages after a while
  nix.gc = {
    automatic = true;
    dates = "weekly UTC";
  };
}


