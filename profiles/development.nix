{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules/development
    ../modules/editors
  ];

  services.flatpak.packages = lib.mkIf config.local.services.flatpak.enable [
    "dev.zed.Zed"                                   # Zed Editor

    "org.virt_manager.virt-manager"                 # Virtual Machine Manager
    "org.virt_manager.virt_manager.Extension.Qemu"  # Virtual Machine Manager (QEMU Extension)
  ];
}
