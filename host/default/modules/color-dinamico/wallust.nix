{ config, pkgs, ... }:

let
  # Si quieres los templates como archivos externos (recomendado)
  templatesDir = ../templates;  # ruta relativa al archivo .nix
in {
  xdg.configFile."wallust/wallust.toml".text = ''
    backend = "fastresize"
    color_space = "lab"
    palette = "dark16"

    [templates]
    waybar = { template = 'waybar.css', target = '~/.config/waybar/colors-wallust.css' }
    dunst = { template = 'dunstrc', target = '~/.config/dunst/dunstrc' }
    hyprland = { template = 'hyprland.conf', target = '~/.config/hypr/wallust-colors.conf' }
  '';

  # Copiar los archivos .template desde la carpeta externa
  xdg.configFile."wallust/templates/waybar.css".source = "${templatesDir}/waybar.css.template";
  xdg.configFile."wallust/templates/dunstrc".source = "${templatesDir}/dunstrc.template";
  xdg.configFile."wallust/templates/hyprland.conf".source = "${templatesDir}/hyprland.conf.template";
}