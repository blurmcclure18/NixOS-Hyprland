{ configs, pkgs, ... }:

{
  services.flatpak = {
    enable = true;
    update.auto.enable = false;
    uninstallUnmanaged = false;

    packages = [
      { 
        #appId = "app.zen_browser.zen";
        #origin = "flathub";
      }
    ];
  };
}

