{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;

    # Configuración general (sección [global])
    settings = {
      global = {
       # font = "Monospace 10";
        allow_markup = true;
        format = "<b>%s</b>\n%b";
        alignment = "left";
        show_age_threshold = 60;
        word_wrap = true;
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;
        icon_position = "left";
        max_icon_size = 32;
        progress_bar = true;
        progress_bar_height = 5;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 280;
        progress_bar_max_width = 300;
        indicate_hidden = true;
        transparency = 0;
        separator_height = 2;
        padding = 10;
        horizontal_padding = 15;
        text_icon_padding = 0;
        frame_width = 0;
       # frame_color = "#424245";
        #separator_color = "frame";
        sort = true;
        idle_threshold = 120;
        monitor = 0;
        follow = "none";
        corner_radius = 3;
        width = "(250, 500)";
        height = "(0, 300)";
        origin = "top-right";
        offset = "20x20";
        shrink = false;
        notification_limit = 20;
        #highlight = "#908AB5";
      };

      # Atajos de teclado
      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
      };

      # Urgencias
      urgency_low = {
       # background = "#1c1c1c";
        timeout = 5;
      };
      urgency_normal = {
       # background = "#1C1C1E";
        timeout = 8;
      };
      urgency_critical = {
       # background = "#4C4A63";
        timeout = 0;
      };
    };
  };
}
