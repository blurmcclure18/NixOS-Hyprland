{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
   prismlauncher # 3rd party launcher for minecraft 
  ];
}
