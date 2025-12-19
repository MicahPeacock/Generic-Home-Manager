{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  xdg.enable = true;

  home.packages = with pkgs; [
    bat
    duf
    eza
    fzf
  ];

  home.shellAliases = {
    hms = "home-manager switch --flake ~/.config/home-manager#$(uname -n)";
  };

  programs.git = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration  = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration  = true;
    enableFishIntegration = true;
  };

  programs.fastfetch.enable = true;

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration  = true;
    enableFishIntegration = true;
  };

  home.file = {
    ".config/fastfetch/config.jsonc".source = ../files/.config/fastfetch/config.jsonc;
    ".config/starship/starship.toml".source = ../files/.config/starship/starship.toml;
  };
}
