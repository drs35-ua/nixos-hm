{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      layer = "top";
      position = "top";
      modules-left = [ "custom/weather" "clock" "custom/warp" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [ "temperature" "pulseaudio" "custom/restart" "custom/poweroff" ];

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
    };
  };
}