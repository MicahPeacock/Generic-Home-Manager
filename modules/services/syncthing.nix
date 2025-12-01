{ config, lib, pkgs, ... }:
let
  cfg = config.local.services.syncthing;
in
{
  options.local.services.syncthing = {
    enable = lib.mkEnableOption "Enable Syncthing service";
  };

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      settings = {
        devices = {
          "minerva" = { id = "UI7RS6E-Y7Q7FZU-WTJPMDQ-QSNVTOD-6DKH2UE-X4DNWEO-F4HCITO-4FXCMAT"; };
          "jupiter" = { id = "2LSN7XS-XF4VXMH-CD36EAO-HNRABCM-DYPXZLM-2XJMTRR-TTMZYTL-B7WVNQQ"; };
          "mercury" = { id = "ELTO64J-HQPJAW4-R5UNGGU-NKLHVGO-AU2XUP6-Q6F36YF-SRZYGLR-A2FOGAW"; };
        };
        folders = {
          "Documents/Personal Documents" = {
            path = "~/Documents/Personal\ Documents";
            devices = [ "jupiter" "mercury" "minerva" ];
          };
          "Documents/TTRPG Files" = {
            path = "~/Documents/TTRPG\ Files";
            devices = [ "jupiter" "mercury" "minerva" ];
          };
          "Music" = {
            path = "~/Music";
            devices = [ "jupiter" "mercury" "minerva" ];
          };
          "Pictures" = {
            path = "~/Pictures";
            devices = [ "jupiter" "mercury" "minerva" ];
          };
          "Videos" = {
            path = "~/Videos";
            devices = [ "jupiter" "mercury" "minerva" ];
          };
        };
      };
    };
  };
}
