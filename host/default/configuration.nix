# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
	inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

boot.loader.grub = {
  enable = true;
  efiSupport = true;          # Necesario para UEFI
  useOSProber = true;
  efiInstallAsRemovable = false; # No lo hagas removable a>
  device = "nodev";           # Para UEFI se usa "nodev"
  configurationLimit = 10;    # Número de generaciones a m>
  # Opcional: mostrar submenú (por defecto sí)
  # enableCryptodisk = true;  # Si usas cifrado
};

nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
};



hardware.graphics = {
    enable = true;
    enable32Bit = true; # Necesario para Steam y juegos de>
  };

services.xserver.videoDrivers = [ "nvidia" ];
programs.nix-ld.enable = true;

hardware.nvidia = {
    # El "modesetting" es obligatorio.
    modesetting.enable = true;

    # Usar los drivers de código abierto (funciona muy bie>
    # Si encuentras problemas, cámbialo a "false" para usa>
    open = true;

    # Activar el menú de configuración de NVIDIA (opcional)
    nvidiaSettings = true;

    # Forzar el uso del driver "stable".
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

hardware.nvidia.powerManagement.enable = true;

security.sudo.extraRules = [
  { users = [ "dani" ];
    commands = [ { command = "/home/dani/.local/bin/cambiar-avatar"; options = [ "NOPASSWD" ]; } ];
  }
];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.

#Audio del bueno
services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;

};
services.pulseaudio.enable = false;

hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;  # Powers the adapter at boot
    settings = {
      General = {
        Name = "MyNixOS-Laptop"; # Your PC's Bluetooth name
        ControllerMode = "dual"; # Supports both BR/EDR and LE
        Experimental = true;   # Required for some features
      };
      Policy = {
        AutoEnable = true;  # Automatically enables all adapters
      };
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  programs.hyprland.enable = true;
  programs.dconf.enable = true;
  programs.localsend.enable = true;

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.flatpak.enable = true;
  services.cloudflare-warp.enable = true;
  services.gvfs.enable = true;
  security.rtkit.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };


fonts.packages = with pkgs; [
        font-awesome
        material-icons
        nerd-fonts.fira-code
        noto-fonts
];

  # Configure console keymap
  console.keyMap = "es";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dani = {
    isNormalUser = true;
    description = "dani";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

home-manager = {
  #useGlobalPkgs = true;
  #useUserPackages = true;
  extraSpecialArgs = { inherit inputs; };
	users = {
		"dani" = import ./home.nix;
	};
};


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    #hyprland
    git
    #wofi

    firefox
    pamixer
    pavucontrol
    #mission-center
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

environment.shellAliases = {
  nixconf = "nano ~/.nixflakes/host/default/configuration.nix";
  nixrebuild = "sudo nixos-rebuild switch --flake ~/.nixflakes#nixos";
};


}
