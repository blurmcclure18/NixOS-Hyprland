{ configs, pkgs, ... }:

{
  home.file.".config/gophertube/gophertube.toml".text = '' 
    search_limit = 30
    quality = "1080p"
    downloads_path = "$HOME/Videos/GopherTube"
  '';
}

