{pkgs, inputs, ...}: {

  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;  # 8 GB Swap
  }];
  zramSwap = {
    enable = true;
    memoryMax = 32 * 1024 * 1024 * 1024;  # 32 GB ZRAM
  };

  environment.systemPackages = [
    inputs.nix-gaming.packages.${system}.rsi-launcher

   # Possibly required to fix audio
   # inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.star-citizen.override {
   #     tricks = [ "arial" "vcrun2019" "win10" "sound=alsa" ];
   # };

  ];
}
