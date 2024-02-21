{ config, pkgs, ... }:

{
  imports =
    [
      ./configs/system
      ./hardware-configuration.nix
      ./home.nix
    ];


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  services.gnome.gnome-keyring.enable = true;


  # Set your time zone.
  time.timeZone = "Africa/Tripoli";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
    services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  programs.kdeconnect.enable = true;
  programs.dconf.enable = true;

  # Configure keymap in X11
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;



  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.khairy = {
    isNormalUser = true;
    description = "khairy";
    extraGroups = [ "networkmanager" "wheel" "input" "kvm" "libvirtd" "disk" "video" ];
    packages = with pkgs; [

    ];
  };


  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowInsecure = true;
  nixpkgs.config.PermittedInsecurePackages = [
  
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  gedit
  neofetch
  google-chrome
  spotify
  spotify-tray
  bitwarden
  ardour
  audacity
  vlc
  mpv
  pencil
  scribus
  gimp-with-plugins
  inkscape-with-extensions
  krita
  darktable
  digikam
  libsForQt5.kdenlive
  handbrake
  blender
  freecad
  #natron
  obs-studio
  obs-studio-plugins.wlrobs
  obs-studio-plugins.obs-gstreamer
  obs-studio-plugins.obs-pipewire-audio-capture

  themix-gui
  cava 

  qjackctl
  godot_4
  aseprite
  material-cursors

  vscodium
  vscode-extensions.jdinhlife.gruvbox
  
  gitFull

  cool-retro-term

  sunshine
  
  appflowy
  joplin-desktop

  thunderbird
  birdtray
  libreoffice-qt

  gparted  
  jellyfin-media-player
  
  ffmpeg-full

  ];




  # Steam Configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
   
  networking.firewall = {
  enable = true;
  allowedTCPPorts = [ ];
  allowedUDPPortRanges = [
  ];
};




  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
