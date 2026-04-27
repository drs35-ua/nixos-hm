{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    # Configuración de fuente (opcional)
    font = {
     # name = "JetBrains Mono";
      size = 12;
    };
    
    # Tema (opcional)
    themeFile = "1984_dark";
    
    settings = {
      # Aquí solo pones las opciones que quieres personalizar.
      # Las opciones que no escribas, Kitty usará sus valores por defecto.
      # Añade esta línea para que el cursor parpadee.
      cursor_blink_interval = "0.5"; 
      
      # Elimina todas las demás líneas que tenía, como:
      # background_opacity, window_padding_width, etc.
    };
  };
}
