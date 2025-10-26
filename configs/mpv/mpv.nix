{configs, pkgs, ... }:

{
  home.file.".config/mpv/mpv.conf".text = '' 
    script-opts-append=ytdl_hook-ytdl_path=/run/current-system/sw/bin/yt-dlp
  '';
}
