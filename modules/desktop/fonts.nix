{ config, lib, pkgs, ... }:
let
  cfg = config.local.desktop.fonts;
in
{
  options.local.desktop.fonts = {
    enable = lib.mkEnableOption "Enable loading of desktop fonts";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      nerd-fonts.jetbrains-mono
      nerd-fonts.mononoki

      cantarell-fonts
      inter
    ];

    fonts.fontconfig.enable = true;
  };
}
