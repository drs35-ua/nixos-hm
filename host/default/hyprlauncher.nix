{ config, pkgs, ... }:

{
  # Coloca el archivo de configuración en ~/.config/hypr/hyprlauncher.conf
  xdg.configFile."hypr/hyprlauncher.conf".text = ''
    # Configuración de la interfaz (UI)
    [ui]
    # Tamaño de la ventana (ancho alto)
    window_size = "400 260"
    
    # Opcional: posición de la ventana (ej. "center", "top", "bottom")
    # position = "center"
    
    # Opcional: opacidad de la ventana (0.0 - 1.0)
    # opacity = 0.95
    
    # Opcional: redondeo de las esquinas (píxeles)
    # rounding = 8

    # Prefijos para los diferentes motores de búsqueda
    [finders]
    # Buscador predeterminado (desktop, unicode, math, font)
    default_finder = "desktop"
    desktop_prefix = ""
    unicode_prefix = "."
    math_prefix = "="
    font_prefix = "'"

    # Configuración de colores (a través del tema de hyprtoolkit)
    # Generalmente hyprlauncher usa el tema por defecto del sistema,
    # pero puedes forzar valores específicos en hyprtoolkit.conf.
    # Si quieres temas oscuros/claros, ajusta 'theme' en hyprtoolkit.
  '';

  # Si quieres gestionar también el tema de hyprtoolkit para colores,
  # descomenta la siguiente línea y crea el archivo correspondiente.
   xdg.configFile."hypr/hyprtoolkit.conf".text = ''
     theme = "dark"
     accent_color = "0xffb4b4"   # ejemplo
   '';
}