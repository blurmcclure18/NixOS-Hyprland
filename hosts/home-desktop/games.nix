{ config, lib, pkgs, unstable,  ... }:

{
  environment.systemPackages = with pkgs; [
   prismlauncher # 3rd party launcher for minecraft 
  ] ++ (with unstable; [
    jdk25
  ]);
}
