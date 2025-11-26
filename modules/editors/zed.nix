{ config, lib, pkgs, ... }:

{
  programs.zed = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.zed;
  };

  home.file.".config/zed/settings.json".source = ../../files/.config/zed/settings.json;
}
