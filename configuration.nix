## Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

    boot = {

	plymouth = {
		enable = true;
	};

	# Enable Systemd initrd
	initrd.systemd.enable = true;

	# Enable Silent Boot
	consoleLogLevel = 3;
	initrd.verbose = false;
	kernelParams = [
		"quiet"
		"splash"
		"boot.shell_on_fail"
		"udev.log_priority=3"
		"rd.systemd.show_status=auto"
	];

	# Hide the OS choice for bootloaders
	# It's still possible to open the bootloader list by pressing any key
	# It will just not appear on screen unless a key is pressed
	loader.timeout = 0;
    };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Systemd-logind to manage power events
  services.logind = {

  # Default behavior - suspend when closed
  lidSwitch = "suspend";

  # Don't suspend when external monitor (dock) is active
  lidSwitchDocked = "ignore";

  # When user is idle and closes lid, same as lidSwitch
  lidSwitchExternalPower = "suspend";
  };

  # Enable acpid service
  services.acpid.enable = true;

   networking.hostName = "test-nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager = {
		enable = true;  # Easiest to use and most distros use this by default.
		wifi = {
			backend = "iwd";
		};
		plugins = with pkgs; [networkmanager-openconnect];
	};

  # Set your time zone.
   time.timeZone = "America/Chicago";

  # Enable Hyprland
  programs.hyprland = {
  	enable = true;
	xwayland.enable = true;
	};

# Enable Greetd display manager
#  services.greetd = {
#	enable = true;
#	settings = {
#		default_session = {
#			command = "Hyprland";
#			user = "alec";
#		};
#	};
#  };

  # Enable ly TUI display manager
  services.displayManager.ly.enable = true;

  services.displayManager.defaultSession = "hyprland";
  #services.displayManager.autoLogin.enable = true;
  #services.displayManager.autoLogin.user = "alec";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Set the default shell for all users
   programs.zsh = {
	enable = true;
   	autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

	# Oh-My-ZSH config
	ohMyZsh = {
		enable = true;
		theme = "af-magic";
		plugins = [
			"fzf"
			"git"
			"history-substring-search"
		];
	};
  };
  programs.starship.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.alec = {
   	isNormalUser = true;
	extraGroups = [ "networkmanager" "wheel" ];
	};

   nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
		config = { allowUnfree = true; };
	  		};
    	};
	};

	fonts.packages = with pkgs; [
		fira-code
		jetbrains-mono
		nerd-fonts.caskaydia-mono
		];

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
	 acpi
	 adwaita-icon-theme
     alacritty
     btop
	 brightnessctl
     cliphist
     curl
     firefox
 	 fzf
     git
  	 gnumake
     hyprlock
	 impala
     mpv
     kitty
     neovim
	 networkmanagerapplet
     nix-search-cli
     openconnect
     pavucontrol
	 playerctl
	 power-profiles-daemon
	 python314
	 ripgrep
	 rofi-wayland
	 swww
     vim
     vmware-horizon-client
	 wallust
     walker
     waybar
     wget
     unstable.wiremix
	 unzip
	 wl-clipboard
     wlogout
	 xfce.thunar
     yazi
	 youtube-dl
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
