{ pkgs, config, ... }:

{
  imports = [

    # Enable &/ Configure Programs
    ./hyprland.nix
    ./bash.nix

  ];
}
