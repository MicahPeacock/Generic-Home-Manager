{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules/system
  ];

  local = {
    programs.coolercontrol.enable = lib.mkDefault true;
    programs.lact.enable          = lib.mkDefault true;
  };

  services.flatpak.packages = lib.mkIf config.local.services.flatpak.enable [
    "org.prismlauncher.PrismLauncher"   # Prism Launcher
    "com.github.Matoking.protontricks"  # Protontricks
    "net.davidotek.pupgui2"             # ProtonUp-Qt
  ];
}
