{
  pkgs,
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

  # Home-Manager : on garde tes paquets ET on active Hydenix HM (thème + hyprland)
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        github-desktop
        obsidian
      ];
    })

    # ➜ Import des modules HM Hydenix (graphs, thèmes, hyprland configs…)
    (import ../../hydenix/modules/hm)

    # ➜ Activation des options Hydenix HM
    (_: {
      hydenix.hm.enable = true;
      hydenix.hm.hyprland.enable = true;

      hydenix.hm.theme.enable = true;
      hydenix.hm.theme.active = "Catppuccin Mocha"; # ou "Catppuccin Latte"
    })
  ];

  # Activation de nix-index-database (système, pas HM)
  programs.nix-index-database = {
    enable = true;
    comma.enable = true;
  };

  # Paquets système
  environment.systemPackages = with pkgs; [ ];

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
