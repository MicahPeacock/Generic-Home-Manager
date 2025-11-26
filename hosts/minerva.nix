{ config, nixgl, pkgs, ... }:

{
  imports = [
    ../profiles/base.nix
    ../profiles/desktop.nix
    ../profiles/development.nix
    ../profiles/office.nix
  ];

  targets.genericLinux.enable = true;
  targets.genericLinux.nixGL = {
    packages = nixgl.packages;
    defaultWrapper = "mesa";
    installScripts = [ "mesa" ];
  };

  local = {
    programs.shell.default = "fish";
    programs.wezterm = {
      enable = true;
      theme = "Kanagawa Dragon (Gogh)";
      font = {
        name = "CaskaydiaCove Nerd Font Mono";
        size = 10;
      };
    };
  };

  home.username = "micahpeacock";
  home.homeDirectory = "/home/micahpeacock";

  home.stateVersion = "25.05"; # Please read the comment before changing.
}
