{ pkgs, lib, inputs,
  username, editor, browser, terminal, terminalFileManager,
  theme, sddmTheme ? null, wallpaper ? null,
  videoDriver, hostname, locale, timezone, kbdLayout, kbdVariant ? "", consoleKeymap,
  outputs ? null, ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/video/${videoDriver}.nix
    ../../modules/hardware/drives

    ../common.nix
    ../../modules/scripts

    ../../modules/desktop/hyprland
    ../../modules/themes/${theme}

    ../../modules/programs/games
    ../../modules/programs/browser/${browser}
    ../../modules/programs/terminal/${terminal}
    ../../modules/programs/editor/${editor}
    ../../modules/programs/editor/vscode
    ../../modules/programs/cli/${terminalFileManager}
    ../../modules/programs/cli/starship
    ../../modules/programs/cli/tmux
    ../../modules/programs/cli/direnv
    ../../modules/programs/cli/lazygit
    ../../modules/programs/cli/cava
    ../../modules/programs/cli/btop
    ../../modules/programs/shell/bash
    ../../modules/programs/shell/zsh
    ../../modules/programs/media/discord
    ../../modules/programs/media/spicetify
    ../../modules/programs/media/mpv
    ../../modules/programs/misc/tlp
    ../../modules/programs/misc/thunar
    ../../modules/programs/misc/lact
  ];

  nixpkgs.config.allowUnfree = true;

  i18n.defaultLocale = locale;
  i18n.extraLocaleSettings.LC_TIME = locale;
  time.timeZone = timezone;
  console.keyMap = consoleKeymap;

  services.xserver = {
    enable = true;
    xkb.layout = kbdLayout;
    xkb.variant = kbdVariant;
  };

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = lib.mkIf (sddmTheme != null) sddmTheme;
    };
    sessionPackages = [ pkgs.hyprland ];
  };

  programs.hyprland.enable = true;

  # Configuration bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-hyprland ];
  xdg.mime.enable = true;

  hardware.graphics = { enable = true; enable32Bit = true; };

  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  
  # Configuration firewall sécurisée
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8200 ];  # minidlna
    allowedUDPPorts = [ 1900 ];  # SSDP pour DLNA
    extraCommands = ''
      # Protection contre les scans de ports
      iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
      iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
    '';
  };

  security.polkit.enable = true;
  
  # Hardening système progressif
  security = {
    sudo.wheelNeedsPassword = true;  # Mot de passe requis pour sudo
    protectKernelImage = true;       # Protection du noyau
    apparmor.enable = true;          # MAC (Mandatory Access Control)
  };
  
  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts noto-fonts-cjk-sans noto-fonts-emoji
    nerd-fonts.jetbrains-mono nerd-fonts.fira-code nerd-fonts.iosevka
  ];

  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = lib.mkIf (videoDriver == "nvidia") true;
  users.groups.docker.members = [ username ];

  # Configuration Podman (rootless + distrobox)
  virtualisation.podman = {
    enable = true;
    dockerCompat = false;  # Garde Docker séparé
    defaultNetwork.settings.dns_enabled = true;
  };
  virtualisation.containers.enable = true;
  
  # Configuration utilisateur
  users.users.${username} = {
    isNormalUser = true;
    group = username;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
  };
  users.groups.${username} = {};

  environment.systemPackages = with pkgs; [
    ansible terraform k3d kubectl kubectl-ai helm docker podman distrobox jenkins
    gemini-cli codex k9s git
    nodejs_20 python3 go rustc cargo
    curl jq btop iotop nethogs nmap tree wget rsync p7zip zip unzip
    obs-studio gimp inkscape blender
    brave librewolf
  ];

  # Configuration home-manager utilisateur
  home-manager.users.${username} = {
    home.stateVersion = "25.05";
    home.packages = with pkgs; [
      github-desktop
      obsidian
      telegram-desktop
      bitwarden
    ];
  };

  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      friendly_name = "Agentic_NixOS-DLNA";
      media_dir = [
        "/mnt/work/Pimsleur"
        "/mnt/work/Media/Films"
        "/mnt/work/Media/Series"
        "/mnt/work/Media/Videos"
        "/mnt/work/Media/Music"
      ];
      inotify = "yes";
      log_level = "error";
    };
  };
  users.users.minidlna.extraGroups = [ "users" ];

  boot.kernel.sysctl = {
    # Performance VM
    "vm.swappiness" = 10;
    "vm.dirty_ratio" = 15;
    "vm.dirty_background_ratio" = 5;
    
    # Hardening réseau
    "net.ipv4.ip_forward" = 0;                    # Pas de routage IP
    "net.ipv4.conf.all.send_redirects" = 0;      # Pas de redirections ICMP
    "net.ipv4.conf.all.accept_redirects" = 0;    # Refuse les redirections
    "net.ipv4.conf.all.accept_source_route" = 0; # Refuse source routing
    "net.ipv4.icmp_echo_ignore_broadcasts" = 1;  # Ignore ping broadcast
    "net.ipv4.tcp_syncookies" = 1;               # Protection SYN flood
  };

  system.stateVersion = "25.05";
}
