{ config, lib, pkgs, ... }:
let
  cfg = config.local.editors.zed-editor;
in
{
  options.local.editors.zed-editor = {
    enable = lib.mkEnableOption "Enable Zed Editor";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      zed-editor
    ];
  };
}
