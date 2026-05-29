{configs, inputs, lib, pkgs, unstable, self, ... }:

{
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
       	loader.timeout = 3;
    };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable Nix Garbage Collector
  nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 7d";
  };

  # Enable Systemd-logind to manage power events
  services.logind.settings.Login = {
	
	# Default behavior - suspend when closed
  	HandleLidSwitch = "suspend";

  	# Don't suspend when external monitor (dock) is active
  	HandleLidSwitchDocked = "ignore";

  	# When user is idle and closes lid, same as lidSwitch
  	HandleLidSwitchExternalPower = "suspend";
  };

  # Enable acpid service
  services.acpid.enable = true;

  # enable polkit
  security.polkit.enable = true;

  # enable XDG
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
	pkgs.xdg-desktop-portal-gtk
  ];

  # Enable Bluetooth
  hardware.bluetooth = {
	enable = true;
	powerOnBoot = true;
  };

  # Enable QMK access for non-root users
  hardware.keyboard.qmk.enable = true;

  services.blueman.enable = true;

  networking.networkmanager = {
	enable = true;  # Easiest to use and most distros use this by default.
	wifi = {
		backend = "iwd";
	};
	plugins = with pkgs; [networkmanager-openconnect];
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  environment.variables = {
	TZ = "America/Chicago";
  };

  # Enable Hyprland
  programs.hyprland = {
  	enable = true;
	xwayland.enable = true;
	};

# Enable Greetd display manager
  services.greetd = {
	enable = true;
	settings = {
		default_session = {
			command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
			user = "alec";
		};
	};
  };

  # Enable ly TUI display manager
  #services.displayManager.ly.enable = true;

  services.displayManager.defaultSession = "hyprland";
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "alec";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # USB auto-mount service
  services.udisks2.enable = true;

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
	extraGroups = [ "input" "networkmanager" "wheel" ];
	};

  nixpkgs.config = {
    allowUnfree = true;
  };

  fonts = {
	enableDefaultPackages = true;

	packages = with pkgs; [
	fira-code
	jetbrains-mono
	nerd-fonts.caskaydia-mono
	noto-fonts
	noto-fonts-cjk-sans
	noto-fonts-color-emoji

	# Horizon Fonts Test
	dejavu_fonts
	liberation_ttf
	];

	#fontconfig.enable = true;
	#fontDir.enable = true;

    };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
	acpi
	adwaita-icon-theme
	alacritty
	bluetui
	bluez
	btop
	brightnessctl
	cargo
	clang
	cmake
	curl
	discord
	dua
	dysk
	firefox
	fzf
	gcc
	ghostty
	git
	gnumake
	tuigreet
	impala
	inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
	mpv
	neovim
	networkmanagerapplet
	nix-search-cli
	#omnissa-horizon-client
	openconnect
	pamixer
	pavucontrol
	playerctl
	power-profiles-daemon
	python314
	ripgrep
	vim
	wget
	unzip
	yazi
	yt-dlp
  ] ++ (with unstable; [
	espanso-wayland
	wiremix
  ]);
  # Enable MPRIS for MPV
    nixpkgs.overlays = [
	(self: super: {
	    mpv = super.mpv.override {
		scripts = [ self.mpvScripts.mpris ];
	    };
        })
    ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
