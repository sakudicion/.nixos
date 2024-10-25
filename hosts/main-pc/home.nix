{ config, pkgs, modulesPath, ... }:

{

  imports =
    [
      ../../modules/main-pc/home/hyprland/hyprland.nix
      ../../modules/main-pc/home/hyprland/ags.nix
      ../../modules/main-pc/home/hyprland/gtk.nix
      ../../modules/main-pc/home/thunar.nix
      ../../modules/main-pc/home/spicetify.nix
      ../../modules/main-pc/home/kitty.nix
    ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.05"; 
  nixpkgs.config.allowUnfree = true;


  home.packages = with pkgs; [

	# Fetch Me
	fastfetch
	neofetch

	# System
	neovim
	eza
	vscode
	pavucontrol
	htop
	tldr
	git
	onlyoffice-desktopeditors

	# Browser and Social
	firefox
	vesktop

	# Music and Video
	obs-studio
	vlc

	# Games
	lutris
	protonplus
	mangohud
	lunar-client	

  ];

  # Set monitors resolution
  wayland.windowManager.hyprland.settings = {
    monitor = "HDMI-A-1,1920x1080@144,0x0,1";
  };

  programs.bash = {
  	enable = true;
  	bashrcExtra = ''
	PS1="\[\e[38;5;153;1;2m\] \[\e[39m\] \[\e[38;5;153m\]User\[\e[39m\] \[\e[38;5;153m\]\W\[\e[39m\] \[\e[0m\] "
  	'';
  	shellAliases = {
  		nixr = "sudo nixos-rebuild switch --flake ~/.nixos#main-pc";
  		nixc = "sudo nvim ~/.nixos/hosts/main-pc/configuration.nix";
  		homec = "sudo nvim ~/.nixos/hosts/main-pc/home.nix";
  		flakec = "sudo nvim ~/.nixos/flake.nix";
  		nixe = "sudo nix-collect-garbage -d && sudo nixos-rebuild switch --flake ~/.nixos#main-pc";
  		nvim = "sudo nvim";
  		ls = "eza --icons";
  	};
  };

  home.sessionVariables = {
  	EDITOR = "nvim";
  	BROWSER = "firefox";
  	GBM_BACKEND = "nvidia-drm";
  	__GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  programs.home-manager.enable = true;
  
}
