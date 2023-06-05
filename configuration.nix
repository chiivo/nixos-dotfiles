# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.efi.efiSysMountPoint = "/boot/efi";

	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "America/Los_Angeles";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	# Configure keymap in X11
	services.xserver = {
		layout = "us";
		xkbVariant = "";
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.chivo = {
		isNormalUser = true;
		description = "Salvador Sesmas";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		gcc
		wget
		git
		p7zip
		alsa-utils
		bottom
		neovim
		cbonsai
		nitch
		phinger-cursors
		papirus-icon-theme
		orchis-theme
		rofi
		lxappearance
		pavucontrol
		alacritty
		joshuto
		xfce.thunar
		xfce.tumbler
		xfce.xfconf
		gvfs
		firefox
		emacs
		blender
		krita
		picom
		discord
		discocss
		maim
		xclip
		libnotify
		mpv
		dwt1-shell-color-scripts
		heroic
		prismlauncher
		retroarch
		rpcs3
		nsxiv
		zathura
		sound-theme-freedesktop
		via
		numlockx
	];

  fonts = {
	enableDefaultFonts = true;
		fonts = with pkgs; [
			victor-mono
		];
		fontconfig = {
			defaultFonts = {
				serif = [ "Redaction" ];
				sansSerif = [ "Liberation Sans" ];
				monospace = [ "VictorMono" "Powerline Extra Symbols" "Font Awesome 6 Pro" "Font Awesome 6 Brands" ];
			};
		};
	};

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# List services that you want to enable:
	# Audio
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	# LightDM and Window Manager
	services.xserver = {
		enable = true;
		displayManager = {
			lightdm = {
				enable = true;
				extraConfig = ''
					[Seat:*]
					greeter-setup-script=/run/current-system/sw/bin/numlockx on
				'';
			};
			defaultSession = "none+awesome";
			lightdm.greeters.mini = {
				enable = true;
				user = "chivo";
				extraConfig = ''
					[greeter]
					show-password-label = false
					password-alignment = center
					[greeter-theme]
					background-image = ""
					background-color = "#262727"
					window-color = "#262727"
					border-color = "#262727"
					border-width = 4px
					password-border-color = "#f5d1c8"
				'';
			};
		};
		windowManager.awesome = {
			enable = true;
		};
	};

	# Bluetooth
	hardware.bluetooth.enable = true;
	environment.etc = {
		"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
			bluez_monitor.properties = {
				["bluez5.enable-sbc-xq"] = true,
				["bluez5.enable-msbc"] = true,
				["bluez5.enable-hw-volume"] = true,
				["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
			}
		'';
	};
	services.blueman.enable = true;

	# Keyboard
	services.udev = {
		packages = with pkgs; [
			vial
			via
		];
		extraRules = ''
			KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
		'';
	};
	
	# Mouse
	services.xserver = {
		libinput.enable = true;
		libinput.mouse.accelProfile = "flat";
		libinput.mouse.accelSpeed = "0";
	};
	hardware.logitech.wireless = {
		enable = true;
		enableGraphical = true;
	};

	# Thunar
	services.gvfs.enable = true;
	services.tumbler.enable = true;

	# Steam
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;

	};

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}