
{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];


  # XanMod Kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Hostname
  networking.hostName = "nixos";


  # Enable networking
  networking.networkmanager.enable = true;


  # Set your time zone.
  time.timeZone = "Europe/Rome";


  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Steam
  programs.steam = {
  	enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };


  # Gamemode
  programs.gamemode.enable = true;


  # Home manager
  home-manager = {
  	extraSpecialArgs = { inherit inputs;};
  	users = {
  		"ash" = import ./home.nix;
  	};
  };


  # AutoMount ExternalDisk
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };


  # Enable the X11 windowing system.
  services.xserver.enable = false;

  
  # SDDM
  services.displayManager.sddm = {
	enable = true;
    wayland.enable = true;
  };


  # Hyprland
  nix.settings = {
	substituters = ["https://hyprland.cachix.org"];
	trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  programs.hyprland.enable = true;


  # My drive
  fileSystems."/mnt/AshFile" = {
    device = "/dev/disk/by-uuid/ce8f9df8-feee-4288-a931-0fc3b6628589";
    fsType = "ext4";
    label = "AshFile";
    options = [ "noatime" ];
  };


  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ash = {
    isNormalUser = true;
    description = "Ash";
    extraGroups = [ "networkmanager" "wheel" ];
  };


  # Install nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.kernelParams = ["nvidia_drm.modeset=1"];
  hardware.graphics.enable = true;
  hardware.nvidia = { 
	package = config.boot.kernelPackages.nvidiaPackages.stable;
  	open = false;
	modesetting.enable = true;
	nvidiaSettings = true;
	powerManagement.enable = false;
    powerManagement.finegrained = false;
  };


  # System version
  system.stateVersion = "24.05";

}
