{ config, pkgs, ... }:

let
  # Ruta absoluta al archivo real (dentro de tu flake)
  realConfig = "/home/dani/.nixflakes/host/default/etc/waypaper-config.ini";
in
{
  # Usa home.file en lugar de xdg.configFile si quieres más control
  home.file.".config/waypaper/config.ini" = {
    source = config.lib.file.mkOutOfStoreSymlink realConfig;
    force = true;   # Sobrescribe si ya existe
  };
}