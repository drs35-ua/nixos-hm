{ config, ... }:

{
  xdg.configFile."waypaper/config.ini".text = ''
    [Settings]
    language = en
    folder = ~/Pictures/fondos
    monitors = All
    wallpaper = ~/Pictures/fondos/wallhaven-zpx3xw.png
    show_path_in_tooltip = True
    backend = swww
    fill = fill
    sort = daterev
    color = #3D3846
    subfolders = False
    all_subfolders = False
    show_hidden = False
    show_gifs_only = False
    zen_mode = False
    post_command = ${config.xdg.configHome}/hypr/scripts/update_wallpaper.sh
    number_of_columns = 3
    swww_transition_type = any
    swww_transition_step = 63
    swww_transition_angle = 0
    swww_transition_duration = 2
    swww_transition_fps = 60
    mpvpaper_sound = False
    mpvpaper_options = 
    use_xdg_state = False
    stylesheet = ~/.config/waypaper/style.css
  '';
}