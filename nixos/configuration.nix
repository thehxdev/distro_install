#################################################
# Author: HxDev                                 #
# Name:   NixOS configuration file              #
#################################################


{ config, pkgs, ... }:

{ imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; 
  boot.loader.timeout = 5;

  # Network Manager
  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Asia/Tehran";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    #keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  ####
  services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.useGlamor = true;
  ####
  #services.xserver.videoDrivers = [ "intel" ];
  #services.xserver.deviceSection = ''
  #  Option "DRI" "2"
  #  Option "TearFree" "true"
  #'';

  # Enable the Desktop Environment.

  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "hx";

  ### KDE
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.displayManager.defaultSession = "plasma";

  ### XFCE
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.displayManager.defaultSession = "xfce";
  #services.xserver.desktopManager.xfce.enable = true;
  #services.xserver.desktopManager.xfce.enableXfwm = true;

  ### Cinnamon
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.cinnamon.enable = true;
  #services.cinnamon.apps.enable = true;

  ### Window Managers
  #services.xserver.windowManager = {
  #  #dwm.enable = true;
  #  #bspwm = {
  #  #  enable = true;
  #  #  configFile = "/home/hx/.config/bspwm/bspwmrc";
  #  #  sxhkd.configFile = "/home/hx/.config/bspwm/sxhkd/sxhkdrc";
  #  #};
  #  #qtile.enable = true;
  #  #xmonad.enable = true;
  #  #xmonad.enableContribAndExtras = true;
  #  #xmonad.extraPackages = hpkgs: [
  #  #  hpkgs.xmonad
  #  #  hpkgs.xmonad-contrib
  #  #  hpkgs.xmonad-extras
  #  #];
  #};

  ### dwm and dmenu config path
  #nixpkgs.overlays = [
  # (final: prev: {
  #   dwm = prev.dwm.overrideAttrs (old: { src = /home/hx/.dwm/dwm ;});
  #   dmenu = prev.dmenu.overrideAttrs (old: { src = /home/hx/.dwm/dmenu ;});
  # })
  #];

  ### picom
  #services.picom = {
  #  enable = true;
  #  fade = false;
  #  shadow = true;
  #  backend = "xrender";
  #  vSync = false;
  #  inactiveOpacity = 1.0;
  #  #activeOpacity = 1.0;
  #  #settings = {
  #    #blur =
  #    #{
  #      #method = "guassian";
  #      #size = 7;
  #      #deviation = 7;
  #    #};
  #  #};
  #};

  # Fonts
  fonts = {
    enableDefaultFonts = true;
  };

  ### gvfs
  services.gvfs.enable = true;

  ### Configure keymap in X11
  services.xserver.layout = "us,ir";
  services.xserver.xkbOptions = "eurosign:e,caps:escape,grp:alt_shift_toggle";

  ### Enable CUPS to print documents.
  #services.printing.enable = true;

  ### Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  ### Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.tapping = true;

  ### Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hx = {
    isNormalUser = true;
    home = "/home/hx";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    #packages = with pkgs; [
    #];
  };

  ### VirtualBox
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  #users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  ### Fish shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish; # set fish to default shell
  
  ### QT Themes
  #programs.qt5ct.enable = true;
  #qt5.enable = true;
  #qt5.platformTheme = "gtk2";
  #qt5.style = "gtk2";

  ### GPU acceleration
  #hardware.opengl.extraPackages = [
  #  pkgs.intel-compute-runtime
  #];

  ### Flatpak
  #services.flatpak.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  ###
  # Then run following commands in terminal:
  # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # flatpak update

  ### List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # Browsers
    #firefox
    #ungoogled-chromium
    brave

    # GTK themes
    #materia-theme
    #flat-remix-gtk

    # Icons
    #pop-icon-theme
    #libsForQt5.breeze-gtk
    #flat-remix-icon-theme
    papirus-icon-theme

    # Editors
    vim 
    neovim
    #emacs
    #ripgrep
    fd

    # Tools
    pcmanfm
    #lxqt.pcmanfm-qt
    #xfce.mousepad
    pavucontrol
    pamixer
    #nitrogen
    rofi
    alacritty
    #kitty
    #dmenu
    arandr
    #vlc
    mpv
    bleachbit

    # Others
    git
    curl
    aria2
    wget
    ffmpeg
    x264
    x265
    libvpx
    python3Full
    afetch
    #pfetch
    #galculator
    #brightnessctl
    #xclip
    #xfce.xfce4-xkb-plugin
    #lxsession
    #lxappearance
    #neofetch
    #tdesktop
    #killall
    viewnior
    yt-dlp
    unrar
    unzip
    gzip
    p7zip
    acpid
    cmake
    gcc
    #nodejs
    #nodePackages.npm
    flameshot
    xdg-utils
    xdg-user-dirs
    font-manager

    # xorg
    xorg.xkill
    xorg.libX11
    xorg.libXinerama
    xorg.libXft
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilkeysyms
    xorg.xcbutilwm
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  ### Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
  #system.stateVersion = "22.11"; # Unstable Version
}

