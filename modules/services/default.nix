{ config, pkgs, ... }:

{
  imports = [
    ./flatpak.nix
    ./syncthing.nix
  ];
}
