{ config, nixgl, pkgs, ... }:

{
  imports = [
    ../profiles/base.nix
    ../profiles/desktop.nix
    ../profiles/development.nix
    ../profiles/gaming.nix
    ../profiles/office.nix
  ];

  targets.genericLinux.enable = true;
  targets.genericLinux.nixGL = {
    packages = nixgl.packages;
    defaultWrapper = "mesa";
    installScripts = [ "mesa" ];
  };

  local = {
    services.flatpak.enable = true;

    programs.shell.default = "fish";
    programs.wezterm = {
      enable = true;
      theme = "One Dark (Gogh)";
      font = {
        name = "CaskaydiaCove Nerd Font Mono";
        size = 10;
      };
    };
  };

  home.username = "deck";
  home.homeDirectory = "/home/deck";

  home.stateVersion = "25.05"; # Please read the comment before changing.
}
