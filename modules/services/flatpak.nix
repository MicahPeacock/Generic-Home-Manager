{ config, lib, nix-flatpak, pkgs, ... }:
let
  cfg = config.local.services.flatpak;
in
{
  options.local.services.flatpak = {
    enable = lib.mkEnableOption "Enable usage of Flatpaks";
  };

  config = lib.mkIf cfg.enable {
    imports = [
      nix-flatpak.homeManagerModules.nix-flatpak
    ];

    services.flatpak = {
      enable = true;
      update.onActivation = true; # Update flatpaks on home-manager switch
    };
  };
}
