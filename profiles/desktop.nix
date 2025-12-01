{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules/desktop
    ../modules/services
    ../modules/shell
    ../modules/terminal
  ];

  local = {
    desktop.fonts.enable    = lib.mkDefault true;
    services.flatpak.enable = lib.mkDefault true;

    programs.shell.default  = lib.mkDefault "bash";
    programs.wezterm.enable = lib.mkDefault true;
  };

  services.flatpak.packages = lib.mkIf config.local.services.flatpak.enable [
    "com.github.tchx84.Flatseal"  # Flatseal
    "it.mijorus.gearlever"        # Gear Lever

    "org.audacityteam.Audacity"   # Audacity
    "com.discordapp.Discord"      # Discord
    "com.spotify.Client"          # Spotify
    "app.zen_browser.zen"         # Zen Browser
  ];
}
