{ config, ... }:
{
  # Clean up packages after a while
  nix.gc = {
    automatic = true;
    dates = "weekly UTC";
  };
}
