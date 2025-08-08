{ pkgs,
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

  # Home-Manager : paquets (sans HM Hydenix)
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        github-desktop
        obsidian
      ];
    })

    # ➜ Activation manuelle des options HM si besoin (sans import)
    (_: {
      hydenix.hm.enable = false;
      hydenix.hm.hyprland.enable = false;
      hydenix.hm.theme.enable = false;
    })
  ];

  # Paquets système
  environment.systemPackages = with pkgs; [
    nix-index
    comma
  ];

  # Hostname (vient des settings du flake)
  networking.hostName = hostname;

  # Exemple : DLNA (tu peux supprimer si inutile)
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
