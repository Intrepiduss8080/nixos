# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./sway.nix
    ];


  
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    timeout = 10;
    efiSupport = true;
    device = "nodev";
    theme = pkgs.stdenv.mkDerivation {
      pname = "minegrub-world-selection";
      version = "1.0.0";
      src = pkgs.fetchFromGitHub {
        owner = "Lxtharia";
        repo = "minegrub-world-sel-theme";
        rev = "master"; 
        hash = "sha256-GvRczS1ZaawnZTkR3XvFQj/wxJo6RJ5NdHc2+F6RI90=";
      };
      installPhase = ''
        mkdir -p "$out"
        cp -r minegrub-world-selection/* "$out/"
      '';
    };
  };


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Mirrors
  nix.settings = {
	substituters = [
	  "https://cache.nixos.org"
	  "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    	  "https://mirror.sjtu.edu.cn/nix-channels/store"
    	  "https://mirrors.ustc.edu.cn/nix-channels/store"
          "https://mirror.nju.edu.cn/nix-channels/store"
    	  "https://mirrors.cernet.edu.cn/nix-channels/store"
   	  "https://nix-community.cachix.org"
    	  "https://cache.garnix.io"
	];

	trusted-public-keys = [
	    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
   	    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    	    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
	];

	connect-timeout = 10;
	download-attempts = 10;
	http-connections = 50;

	fallback = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Saratov";

  # Select internationalisation properties. Any mirrors.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };


  programs.mangowc.enable = true;




  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Budgie Desktop environment.
  services.xserver.displayManager.lightdm.enable = true;
  # services.desktopManager.budgie.enable = true;
  #services.xserver.desktopManager.cinnamon.enable = true;


  services.xserver.desktopManager.xfce.enable = true;




  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."opensor" = {
    isNormalUser = true;
    description = "opensor";

    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

     programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      v = "nvim";
      vim = "nvim";
      ls = "eza --icons";
      ll = "eza -l --icons";
      cat = "bat";
      nixconf = "sudo -E nvim /etc/nixos/configuration.nix";
      rebuild = "sudo nixos-rebuild switch";
    };

    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };

  programs.firefox.enable = true;

  # List packages installed in system profile.
  #  You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim 
    wget
    fastfetch
    git
    gcc
    gnumake
    nodejs
    python3
    unzip
    ripgrep
    fd
    fzf
    eza
    bat
    tree
    lazygit
    zsh-powerlevel10k
    docker
   ];

   
   fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?


  # Flatpak
  services.flatpak.enable = true;


}
