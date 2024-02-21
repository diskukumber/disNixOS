{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
    ./configs/home
  ];

  home-manager.users.khairy = {
    /* The home.stateVersion option does not have a default and must be set */
    home.username = "khairy";
    home.homeDirectory = "/home/khairy";
    home.stateVersion = "24.05";
    home.packages = with pkgs; [
    dconf
    ];    



    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
    services.swayosd.enable = true;


  home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.material-cursors;
      name = "material_light_cursors";
      size = 24;
  };

   dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;
  gtk = {
      enable = true;
      font = {
	name = "Ubuntu";
	size = 12;
	package = pkgs.ubuntu_font_family;
    };
    theme = {
        name = "Gruvbox-Dark-B";
        package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons;
    };
    cursorTheme = {
        name = "material_light_cursors";
        package = pkgs.material-cursors;
    };
    gtk3.extraConfig = {
        Settings = ''
        gtk-application-prefer-dark-theme=1
        '';
    };
    gtk4.extraConfig = {
        Settings = ''
        gtk-application-prefer-dark-theme=1
        '';
    };
  };




  xdg = {
    userDirs = {
        enable = true;
        createDirectories = true;
    };
  };




  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };



  programs.git = {
    enable = true;
    userName  = "diskukumber";
    userEmail = "diskukumber@gmail.com";
  extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };





  programs.home-manager.enable = true;





  };
}
