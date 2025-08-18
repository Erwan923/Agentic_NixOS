{ lib, pkgs, username, wallpaper ? "moon", ... }:

let
  variant = "macchiato";
  accent  = "lavender";
  catppuccinKvantum = pkgs.catppuccin-kvantum.override { inherit variant accent; };
  themeName = "catppuccin-${variant}-${accent}-compact";
  themePkg  = pkgs.catppuccin-gtk.override {
    variant = variant;
    accents = [ accent ];
    size    = "compact";
  };
in
{
  home-manager.users.${username} = { config, pkgs, ... }: {
    # Paquets liés au thème
    home.packages = [
      catppuccinKvantum
      pkgs.colloid-icon-theme
      pkgs.papirus-icon-theme
      pkgs.bibata-cursors
      pkgs.nerd-fonts.jetbrains-mono
    ];

    fonts.fontconfig.enable = true;

    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "kvantum";
    };

    # --- Source de vérité UNIQUE pour GTK ---
    gtk = {
      enable = true;

      theme = {
        name    = lib.mkForce themeName;
        package = lib.mkForce themePkg;
      };

      iconTheme = {
        name    = lib.mkForce "Colloid-teal-dark";
        package = lib.mkForce pkgs.colloid-icon-theme;
      };

      font = {
        name = "JetBrainsMono Nerd Font";
        size = 11;
      };

      gtk3.extraConfig."gtk-application-prefer-dark-theme" = "1";
      gtk4.extraConfig."gtk-application-prefer-dark-theme" = "1";
    };

    # Curseur (avec mkForce pour éviter conflits)
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = lib.mkForce pkgs.bibata-cursors;
      name    = lib.mkForce "Bibata-Modern-Classic";
      size    = lib.mkDefault 24;
    };

    # Lier Kvantum & GTK 4 au thème choisi
    xdg.configFile = {
      "gtk-4.0/assets".source =
        "${themePkg}/share/themes/${themeName}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source =
        "${themePkg}/share/themes/${themeName}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source =
        "${themePkg}/share/themes/${themeName}/gtk-4.0/gtk-dark.css";

      "Kvantum/${themeName}".source =
        "${catppuccinKvantum}/share/Kvantum/${themeName}";
      "Kvantum/kvantum.kvconfig".source =
        (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
          General = {
            theme = themeName;
            blur = true;
            menu_blur = true;
          };
        };
    };

    # Wallpaper Hyprland
    services.hyprpaper = {
      enable = true;
      settings = {
        preload   = [ "${../wallpapers/${wallpaper}.jxl}" ];
        wallpaper = [ ",${../wallpapers/${wallpaper}.jxl}" ];
      };
    };

    # Mode sombre GNOME (apps)
    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
      gtk-theme = lib.mkForce themeName;
    };
  };
}
