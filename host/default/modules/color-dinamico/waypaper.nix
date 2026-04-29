{ config, pkgs, ... }:

let
  # Ruta absoluta al archivo real (dentro de tu flake)
  waypaperConfigFile = "waypaper-config.ini";
in
{
  # Elimina o comenta la línea anterior con xdg.configFile ... text = ...
  # y usa home.file (o xdg.configFile) con mkOutOfStoreSymlink:

  xdg.configFile."waypaper/config.ini" = {
    source = config.lib.file.mkOutOfStoreSymlink waypaperConfigFile;
    # force = true;  # si ya existe un enlace previo, sobrescríbelo
  };
}