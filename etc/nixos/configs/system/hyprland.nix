{ pkgs, ... }:

{

# Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

# Enable Xwayland 
 programs.xwayland = {
  enable = true;
 };

# Enable Waybar
  programs.waybar = {
    enable = true;
  };

# Enable xdg portal
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };


services.dbus.enable = true;
services.gvfs.enable = true;
services.tumbler.enable = true;
services.xserver.updateDbusEnvironment = true;
services.power-profiles-daemon.enable = true;

services.dbus.implementation = "dbus";
boot.initrd.systemd.dbus.enable = true;

# Set Environment Variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    GTK_USE_PORTAL = "1";
    GDK_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    QT_QPA_PLATFORMTHEME = "gtk";

  };

# Installing Packages
  environment.systemPackages = with pkgs; [

    kitty
    rofi-wayland
    swaynotificationcenter
    libnotify
    conky
    swayosd
    swww
    networkmanagerapplet
    pasystray
    pavucontrol
    pamixer
    playerctl
    copyq
    gammastep
    libinput-gestures
    swayidle
    grim
    slurp
    swappy


    wireplumber

    gtklock
    gtklock-userinfo-module
    gtklock-powerbar-module
    gtklock-playerctl-module
    
 
    polkit_gnome

    cinnamon.nemo-with-extensions
    cinnamon.nemo-fileroller
    cinnamon.folder-color-switcher
    cinnamon.nemo-emblems


    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    
    
# thmes
  adwaita-qt
  adwaita-qt6
  kde-gruvbox
  gruvbox-plus-icons
  gruvbox-gtk-theme

  nwg-look
  qt6Packages.qt6ct
  libsForQt5.qt5ct       
       
  ];

# Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-lgc-plus
    noto-fonts-monochrome-emoji
    noto-fonts-color-emoji
    nerdfonts
  ];

# Security
  security = {
    polkit.enable = true;
    # allow wayland lockers to unlock the screen
    pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };


polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';


  };

systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
};



}

