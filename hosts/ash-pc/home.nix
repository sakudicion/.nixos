{ config, pkgs, modulesPath, ... }:

{

  imports =
    [
      ../../modules/hyprland.nix
    ];

  home.username = "ash";
  home.homeDirectory = "/home/ash";
  home.stateVersion = "24.05"; 
  nixpkgs.config.allowUnfree = true;


  home.packages = with pkgs; [

	# Fetch Me
	fastfetch
	neofetch

	# System
	micro
	eza
	librewolf
	appimage-run
	lunarvim
	gedit
	pavucontrol
	htop

	# Browser and Social
	librewolf
	vesktop

	# Music and Video
	obs-studio
	vlc

	# Games
	lutris
	protonplus
	mangohud
	badlion-client

	# Hyprland rice
	waybar
	wlogout
	wofi
	kitty
	git
	xdg-user-dirs
	polkit_gnome
	kdePackages.polkit-kde-agent-1
	hyprpaper
	hyprshot
	bemoji
	xfce.thunar
	wl-clipboard
	breeze-hacked-cursor-theme
];

  # Set monitors resolution
  wayland.windowManager.hyprland.settings = {
    monitor = "HDMI-A-1,1920x1080@144,0x0,1";
  };

  gtk.cursorTheme = "Simp1e Adw Dark";

  programs.bash = {
  	enable = true;
  	bashrcExtra = ''
	PS1="\[\e[38;5;153;1;2m\] 󰣇\[\e[39m\] \[\e[38;5;153m\]Ash\[\e[39m\] \[\e[38;5;153m\]\W\[\e[39m\] \[\e[0m\] "
  	'';
  	shellAliases = {
  		nixr = "sudo nixos-rebuild switch --flake ~/.nixos#ash-pc";
  		nixc = "sudo micro ~/.nixos/hosts/ash-pc/configuration.nix";
  		homec = "sudo micro ~/.nixos/hosts/ash-pc/home.nix";
  		flakec = "sudo micro ~/.nixos/flake.nix";
  		nixe = "sudo nix-collect-garbage -d && sudo nixos-rebuild switch --flake ~/.nixos#ash-pc";
  		micro = "sudo micro";
  		ls = "eza --icons";
  	};
  };

  home.sessionVariables = {
  	EDITOR = "micro";
  	BROWSER = "firefox";
  	GBM_BACKEND = "nvidia-drm";
  	__GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  programs.home-manager.enable = true;
  
}
