{ config, pkgs, ... }:
{
  security.sudo.enable = false;
  security.doas.enable = true;
  security.doas.extraRules = [
    # Allow execution of any command by any user in group wheel, requiring
    # a password and keeping any previously-defined environment variables.
    { groups = [ "wheel" ]; noPass = false; keepEnv = true; }
  ];
}
