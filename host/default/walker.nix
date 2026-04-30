# .../walker.nix
{ config, lib, pkgs, ... }:   # Add this function header
{
  programs.walker = {
    enable = true;
    runAsService = true; # Note: This option is not supported in the NixOS module only in the home-manager module

    config = {
      theme = "default";
      placeholders."default" = { input = "Search"; list = "Example"; };
      providers.prefixes = [
        {provider = "websearch"; prefix = "+";}
        {provider = "providerlist"; prefix = "_";}
      ];
      keybinds.quick_activate = ["F1" "F2" "F3"];
    };


  };
}
