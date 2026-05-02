{ config, pkgs, ... }:

let
  # Si quieres los templates como archivos externos (recomendado)
  templatesDir = ./templates;  # ruta relativa al archivo .nix
in {
  xdg.configFile."wallust/wallust.toml".text = ''
    backend = "fastresize"
    color_space = "lab"
    palette = "dark16"

    [templates]
    waybar = { template = 'waybar.css', target = '~/.config/waybar/colors-wallust.css' }
    dunst = { template = 'dunstrc', target = '~/.config/dunst/dunstrc' }
    hyprland = { template = 'hyprland.conf', target = '~/.config/hypr/wallust-colors.conf' }
    walker = { template = 'waybar.css', target = '~/.config/walker/themes/matheme/colors-wallust.css' }
  '';

}
