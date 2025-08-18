{
  description = "Configuration NixOS moderne, Hyprland + Home Manager, prête pour dev/desktop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland & co (optionnels si tu veux pinner upstream)
    hyprland = { url = "github:hyprwm/Hyprland"; inputs.nixpkgs.follows = "nixpkgs"; };
    hypridle  = { url = "github:hyprwm/hypridle";  inputs.nixpkgs.follows = "nixpkgs"; };
    hyprlock  = { url = "github:hyprwm/hyprlock";  inputs.nixpkgs.follows = "nixpkgs"; };
    hyprpaper = { url = "github:hyprwm/hyprpaper"; inputs.nixpkgs.follows = "nixpkgs"; };

    pyprland = { url = "github:hyprland-community/pyprland"; inputs.nixpkgs.follows = "nixpkgs"; };

    nix-index-database = { url = "github:nix-community/nix-index-database"; inputs.nixpkgs.follows = "nixpkgs"; };
    nur.url = "github:nix-community/NUR";

    spicetify-nix = { url = "github:Gerg-L/spicetify-nix"; inputs.nixpkgs.follows = "nixpkgs"; };

    # Esthétiques/éditeurs (optionnels)
    nixvim = { url = "github:Sly-Harvey/nixvim"; inputs.nixpkgs.follows = "nixpkgs"; };
    nvchad4nix = { url = "github:nix-community/nix4nvchad"; inputs.nixpkgs.follows = "nixpkgs"; };
    zen-browser = { url = "github:maximoffua/zen-browser.nix"; inputs.nixpkgs.follows = "nixpkgs"; };

    betterfox = { url = "github:yokoffing/Betterfox"; flake = false; };
    thunderbird-catppuccin = { url = "github:catppuccin/thunderbird"; flake = false; };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    inherit (self) outputs;

    systems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    settings = {
      # Utilisateur & préférences
      username            = "r3v4n";
      editor              = "nixvim";       # modules/programs/editor/nixvim
      browser             = "firefox";      # modules/programs/browser/firefox
      terminal            = "kitty";        # modules/programs/terminal/kitty
      terminalFileManager = "yazi";         # modules/programs/cli/yazi
      theme               = "Catppuccin";   # modules/themes/Catppuccin
      sddmTheme           = "Catppuccin";
      wallpaper           = "cyberpunk";

      # Système
      videoDriver = "nvidia";               # modules/hardware/video/nvidia.nix
      hostname    = "nixos";
      locale      = "fr_FR.UTF-8";
      timezone    = "Europe/Paris";
      kbdLayout   = "fr";
      kbdVariant  = "";
      consoleKeymap = "fr";
    };
  in
  {
    # si tu as des dev-shells
    templates = if builtins.pathExists ./dev-shells then import ./dev-shells else {};

    overlays = {};
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      Default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # IMPORTANT : on passe bien outputs ici
        specialArgs = { inherit self inputs outputs; } // settings;

        modules = [
          ./hosts/Default/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          ({ pkgs, ... }: {
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
          })
        ];
      };
    };
  };
}
