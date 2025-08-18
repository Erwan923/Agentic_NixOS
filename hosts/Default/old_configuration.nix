{ pkgs, config, inputs, lib,
  videoDriver,
  hostname,
  browser,
  editor,
  terminal,
  terminalFileManager,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/video/${videoDriver}.nix
    ../../modules/hardware/drives

    ../common.nix
    ../../modules/scripts

    # WM/DE
    ../../modules/desktop/hyprland

    # Apps & CLI
    ../../modules/programs/games
    ../../modules/programs/browser/${browser}
    ../../modules/programs/terminal/${terminal}
    ../../modules/programs/editor/${editor}
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

  # Home-Manager : paquets (Hydenix temporairement désactivé)
  home-manager.sharedModules = [
    inputs.nix-index-database.homeModules.nix-index
    (_: {
      # Résolution du conflit de stateVersion
      home.stateVersion = lib.mkForce "25.05";
      
      home.packages = with pkgs; [
        github-desktop
        obsidian
        telegram-desktop
        bitwarden
        swww  # Ajouté directement pour SWWW
      ];
      
      # Configuration SWWW avec le wallpaper Agentic moderne
      wayland.windowManager.hyprland.settings = {
        exec-once = [
          "swww-daemon"
          "swww img ~/nixos-config/modules/themes/wallpapers/Agentic_NIXOS.png --transition-type wipe --transition-duration 2"
        ];
        
        # Couleurs modernes Catppuccin (force les couleurs)
        general = lib.mkForce {
          "col.active_border" = "rgba(cba6f7ee) rgba(89b4faee) 45deg";
          "col.inactive_border" = "rgba(6c7086aa)";
          border_size = 3;
          gaps_in = 8;
          gaps_out = 16;
        };
      };
      
      # Thème Catppuccin Mocha - Moderne et impressionnant !
      gtk = {
        enable = true;
        theme = {
          name = lib.mkForce "Catppuccin-Mocha-Standard-Mauve-Dark";
          package = lib.mkForce (pkgs.catppuccin-gtk.override {
            accents = [ "mauve" ];
            size = "standard";
            variant = "mocha";
          });
        };
        iconTheme = {
          name = lib.mkForce "Papirus-Dark";
          package = lib.mkForce pkgs.papirus-icon-theme;
        };
        cursorTheme = {
          name = lib.mkForce "Catppuccin-Mocha-Mauve-Cursors";
          package = lib.mkForce pkgs.catppuccin-cursors.mochaMauve;
        };
      };
      
      # Force aussi les paramètres dconf pour éviter les conflits
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          gtk-theme = lib.mkForce "Catppuccin-Mocha-Standard-Mauve-Dark";
          icon-theme = lib.mkForce "Papirus-Dark";
          cursor-theme = lib.mkForce "Catppuccin-Mocha-Mauve-Cursors";
          color-scheme = lib.mkForce "prefer-dark";
        };
      };
      
      # Configuration Waybar avec thème Catppuccin
      programs.waybar = {
        enable = true;
        style = ''
          * {
            font-family: 'JetBrains Mono Nerd Font';
            font-size: 13px;
            min-height: 0;
          }
          
          window#waybar {
            background: rgba(30, 30, 46, 0.9);
            color: #cdd6f4;
            border-bottom: 3px solid #cba6f7;
          }
          
          .modules-left, .modules-center, .modules-right {
            padding: 0 10px;
          }
          
          button {
            background: transparent;
            border: none;
            border-radius: 10px;
            margin: 2px;
            padding: 0 10px;
          }
          
          button:hover {
            background: rgba(203, 166, 247, 0.2);
          }
        '';
      };
    })
  ];

  # Paquets système
  environment.systemPackages = with pkgs; [
    nix-index
    comma
    ansible
    terraform
    k3d
    kubectl
    k9s
    helm
    git
    docker
    distrobox
  ];

  # Docker (service + groupe)
  virtualisation.docker.enable = true;
  # Ajoute l'utilisateur au groupe docker sans toucher à users.users.r3v4n.extraGroups
  users.groups.docker.members = [ "r3v4n" ];
  
  # Hostname (vient des settings du flake)
  networking.hostName = hostname;

  # Service DLNA
  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      friendly_name = "NixOS-DLNA";
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
  
  users.users.minidlna = {
    extraGroups = [ "users" ];
  };
}
