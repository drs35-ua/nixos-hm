{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
        mainBar = {
      layer = "top";
      position = "top";
      modules-left = [ "custom/weather" "clock" "custom/warp" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [ "temperature" "battery" "pulseaudio" "custom/restart" "custom/poweroff" ];

      clock = {
        format = "{:%H:%M  %d/%m/%y}";
        rotate = 0;
        actions = {
          on-scroll-down = "shift_up";
          on-scroll-up = "shift_down";
          on-click-middle = "shift_reset";
          on-click-right = "mode";
        };
        tooltip-format = "<span>{calendar}</span>";
        calendar = {
          mode = "month";
          format = {
            months = "<span color='#ffffff'><b>{}</b></span>";
            days = "<span color='#cdd6f4'><b>{}</b></span>";
            weekdays = "<span color='#7CD37C'><b>{}</b></span>";
            today = "<span color='#ffcc66'><b>{}</b></span>";
          };
        };
      };

      pulseaudio = {
        format = "{volume:>3}% 󰓃";
        tooltip = false;
        on-click = "pavucontrol";
        on-scroll-up = "pamixer -i 5 && ~/.config/waybar/scripts/volume_notify.sh";
        on-scroll-down = "pamixer -d 5 && ~/.config/waybar/scripts/volume_notify.sh";
      };

      "custom/warp" = {
        exec = "~/.config/waybar/scripts/warp-status.sh";
        interval = 3;
        return-type = "json";
        format = "{}";
        on-click = "~/.config/waybar/scripts/warp-toggle.sh";
        tooltip = true;
        tooltip-format = "WARP: {alt}";
      };

      temperature = {
        format = " 󰈸 {temperatureC:^2}°C";
        critical-threshold = 80;
        tooltip = true;
      };

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "I";
          "2" = "II";
          "3" = "III";
          "4" = "IV";
          "5" = "V";
          "6" = "VI";
          "7" = "VII";
          "8" = "VIII";
          "9" = "IX";
          "10" = "X";
          default = "○";
        };
        smooth-scrolling-threshold = 3;
        disable-scroll = true;
      };

      "custom/poweroff" = {
        format = "  ";
        on-click = "poweroff";
        tooltip = false;
      };

      "custom/restart" = {
        format = "  ";
        on-click = "reboot";
        tooltip = false;
      };

      "custom/weather" = {
        format = "{}";
        tooltip = true;
        return-type = "json";
        exec = "~/.config/waybar/scripts/weather/get_weather.rb";
        on-click = "~/.config/waybar/scripts/weather/get_weather.rb --next";
        interval = 900;
      };

      battery = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
          interval = 60;
          tooltip = true;
          states = {
            warning = 20;
            critical = 10;
          };
          on-click = "kitty -e btop";  # Ejemplo: abre monitor al hacer clic
        };

    };
    };

    # Estilo CSS (sin dependencia externa, colores fijos basados en Catppuccin Mocha)
    style = ''
      /* Definiciones de colores personalizadas (eliminada dependencia de wallust) */
      @define-color main_color #${scheme.base0D};   /* acento principal */
      @define-color second_color #${scheme.base05}; /* texto principal */
      @define-color first_color #${scheme.base0B};  /* verde/acento secundario */
      @define-color background #${scheme.base00};

      * {
        all: initial;
        font-size: 15px;
        font-family: "${config.stylix.fonts.monospace.name}";
      }

      #workspaces button:hover {
        background-color: @main_color;
        color: @second_color;
      }

      #workspaces button:hover,
      #workspaces button:hover label {
        color: @second_color;
      }

      #workspaces button {
        padding: 0 10px;
        border-bottom: 3px solid rgba(249, 159, 57, 0.00);
        min-width: 25px;
      }

      #workspaces button.active {
        border-bottom: 3px solid @main_color;
        border-radius: 0px;
      }

      tooltip {
        background-color: @background;
        border-radius: 8px;
        padding: 30px;
      }

      #network:hover, #custom-restart:hover {
        background-color: @main_color;
        color: @second_color;
        box-shadow: 0 2px 15px rgba(0,0,0,0.3);
      }

      #custom-poweroff:hover {
        background-color: rgb(232, 18, 18);
        color: rgb(30,30,46);
        box-shadow: 0 2px 15px rgba(0,0,0,0.3);
      }

      window#waybar {
        background: @background;
      }

      #clock, #pulseaudio, #network, #battery, #custom-poweroff, #temperature, #custom-restart, #custom-weather, #custom-warp, #battery {
        padding: 10px 10px;
      }

      #custom-audio-device {
        min-width: 2em;
        margin-left: -10px;
        margin-right: 5px;
      }

      @keyframes blink {
        0% { opacity: 1; }
        50% { opacity: 0.3; }
        100% { opacity: 1; }
      }

      #custom-warp {
        transition: all 0.2s ease;
      }

      #custom-warp.connected {
        color: @first_color;
      }
    '';
  };
}