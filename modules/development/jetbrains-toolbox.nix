{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs.jetbrains-toolbox;
in
{
  options.local.programs.jetbrains-toolbox = {
    enable = lib.mkEnableOption "Enable Jetbrains Toolbox";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (config.lib.nixGL.wrap jetbrains-toolbox)
    ];
  };
}
