{ config, pkgs, ... }:

{
  imports = [

    ./boot.nix
    ./virtualization.nix
    ./sunshine.nix
    ./hyprland.nix
    ./displaymanager.nix
    ./polkit.nix
    ./audio.nix
    ./nvidia.nix

  ];
}

