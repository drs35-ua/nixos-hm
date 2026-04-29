{ config, pkgs, ... }:

let
  realConfig = "${config.home.homeDirectory}/.nixflakes/host/default/etc/waypaper-config.ini";
in
{
  home.file.".config/waypaper/config.ini" = {
    source = config.lib.file.mkOutOfStoreSymlink realConfig;
    force = true;
  };
}