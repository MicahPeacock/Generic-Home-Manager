{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs.alacritty;
  shared = config.local.programs.terminal;
in
{
  options.local.programs.alacritty = {
    enable = lib.mkEnableOption "Enable Alacritty, a fast, cross-platform, OpenGL terminal emulator";
    theme = lib.mkOption {
      type = lib.types.str;
      default = shared.theme;
      description = "Color scheme to use in Alacritty";
    };
    opacity = lib.mkOption {
      type = lib.types.float;
      default = shared.opacity;
      description = "Window opacity to use in Alacritty";
    };
    font.name = lib.mkOption {
      type = lib.types.str;
      default = shared.font.name;
      description = "Font family to use in Alacritty";
    };
    font.size = lib.mkOption {
      type = lib.types.int;
      default = shared.font.size;
      description = "Font size (in px) to use in Alacritty";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.alacritty;

      theme = cfg.theme;
      settings = {
        general.import = [
          "general.toml"
          "keybindings.toml"
          "options.toml"
        ];
      };
    };

    home.file = {
      ".config/alacritty/general.toml".source     = ../../files/.config/alacritty/general.toml;
      ".config/alacritty/keybindings.toml".source = ../../files/.config/alacritty/keybindings.toml;
      ".config/alacritty/options.toml".text = ''
        [terminal]
        shell = "${config.home.homeDirectory}/.nix-profile/bin/${config.local.programs.shell.default}"

        [window]
        opacity = ${builtins.toString cfg.opacity}

        [font]
        size = ${builtins.toString cfg.font.size}

        [font.normal]
        family = "${cfg.font.name}"
        style = "Normal"

        [font.bold]
        family = "${cfg.font.name}"
        style = "Bold"

        [font.italic]
        family = "${cfg.font.name}"
        style = "Italic"

        [font.bold_italic]
        family = "${cfg.font.name}"
        style = "Bold Italic"
      '';
    };
  };
}
