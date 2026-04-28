{ config, pkgs, ... }:

let
  scriptsDir = ./scripts;  # ruta relativa a la carpeta scripts
in


{

imports = [
    ./kitty.nix
    ./waybar.nix
    ./wofi.nix
    ./dunst.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dani";
  home.homeDirectory = "/home/dani";
  nixpkgs.config.allowUnfree = true;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };




  
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    brightnessctl
    awww
    sunsetr
    vlc
    blueman
    bibata-cursors
    ruby
    waypaper
    gnome-software
    vulkan-tools
    btop
    htop
    libnotify
    nwg-look
    wallust
    gnome-themes-extra
    gnome-disk-utility
    udiskie
    ntfs3g
    gnome-calendar
    hyprlauncher
    adw-gtk3
    nemo-with-extensions
	  dolphin-emu
    protonplus
    thunderbird
    xdg-user-dirs   
    xdg-user-dirs-gtk
    vscode
    glib
    gsettings-desktop-schemas
	fastfetch
    dconf
    mission-center
    resources
  ];

dconf.enable = true;

dconf.settings = {
  "org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };
};


    # Configuración de Bash (manera correcta en Home Manager actual)
  # Configuración de Bash
programs.bash = {
  enable = true;
  
  # Aquí van tus aliases y otras configuraciones existentes
  shellAliases = {
    ll = "ls -la";
    la = "ls -a";
    l = "ls -l";
    # Tus alias nix
    nixconf = "nano ~/.nixflakes/host/default/configuration.nix";
    nixrebuild = "sudo nixos-rebuild switch --flake ~/.nixflakes#nixos";
    nixhome = "nano ~/.nixflakes/host/default/home.nix";
  };
  
  # Personalización del prompt
  initExtra = ''
    # Prompt colorido: usuario@hostname (en verde) y directorio actual (en azul)
    export PS1="\[\033[32m\]\u@\h\[\033[0m\]:\[\033[34m\]\w\[\033[0m\]\$ "
  '';
};

  #stylix.targets.waybar.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/waybar/scripts/warp-status.sh" = {
      source = "${scriptsDir}/waybar/warp-status.sh";
      executable = true;
    };
    ".config/waybar/scripts/warp-toggle.sh" = {
      source = "${scriptsDir}/waybar/warp-toggle.sh";
      executable = true;
    };
    ".config/waybar/scripts/volume_notify.sh" = {
      source = "${scriptsDir}/waybar/volume_notify.sh";
      executable = true;
    };
    ".config/waybar/scripts/weather/get_weather.rb" = {
      source = "${scriptsDir}/waybar/weather/get_weather.rb";
      executable = true;
    };

      
    ".config/waybar/scripts/weather/ui_icons.json" = {
      source = ./scripts/waybar/weather/ui_icons.json;
    };
    
    ".config/waybar/scripts/weather/weather_icons.json" = {
      source = ./scripts/waybar/weather/weather_icons.json;
    };
    ".config/waybar/scripts/weather/weather_settings.jsonc" = {
      source = ./scripts/waybar/weather/weather_settings.jsonc;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dani/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs = {
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      extraConfig = ''
        Host github.com
          IdentityFile ~/.ssh/id_ed25519
      '';
    };
    git = {
      enable = true;
      userName = "drs35-ua";
      userEmail = "onsun99@gmail.com";
      extraConfig = {
        core = {
          sshCommand = "ssh -F ~/.ssh/config";  # Usa la config SSH que definiste
        };
      };
    };
  };

  services.ssh-agent.enable = true; 
}
