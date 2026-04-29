{ config, pkgs, ... }:

let
  updateScript = pkgs.writeShellScript "update_wallpaper.sh" ''
    #! /usr/bin/env bash

    WALLPAPER_PATH="''${1:-$(grep -oP '^wallpaper = \K.*' ~/.config/waypaper/config.ini)}"
    WALLPAPER_PATH="''${WALLPAPER_PATH/#\~/$HOME}"

    wallust run -s "$WALLPAPER_PATH"

    pkill -USR2 waybar
    pkill -HUP dunst
  '';
in {
  xdg.configFile."hypr/scripts/update_wallpaper.sh" = {
    source = updateScript;
    executable = true;
  };
}