{ pkgs, config, ... }:

{
  services.xserver = {
    enable = true;
    xkb = {
      variant = "us";
      layout = "us,ara";
      options = "grp:alt_shift_toggle";
    };
    libinput.enable = true;
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      theme = "sugar-dark";
    };
  };

  environment.systemPackages =
let
    packages = pkgs.callPackage ../packages/sddm-sugar-dark-theme.nix {};
in [ 
    packages.sddm-sugar-dark # Name: sugar-dark
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];
}

