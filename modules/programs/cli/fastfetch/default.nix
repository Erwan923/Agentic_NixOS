{ lib, pkgs, username, ... }:

{
  home-manager.users.${username} = {
    programs.fastfetch = {
      enable = true;
      package = pkgs.fastfetch;
    };
    
    home.packages = [ pkgs.fastfetch ];
    
    # Configuration basique avec style Catppuccin
    xdg.configFile."fastfetch/config.jsonc".text = ''
      {
        "logo": {
          "source": "nixos_small",
          "padding": {
            "right": 1
          }
        },
        "display": {
          "separator": "  ",
          "color": {
            "keys": "blue",
            "title": "blue"
          }
        },
        "modules": [
          "title",
          "separator",
          "os",
          "host", 
          "kernel",
          "uptime",
          "packages",
          "shell",
          "display",
          "de",
          "wm",
          "theme",
          "icons",
          "font",
          "terminal",
          "cpu",
          "gpu", 
          "memory",
          "disk",
          "battery",
          "break",
          "colors"
        ]
      }
    '';
  };
}