{ lib, pkgs, inputs, ... }:

# Fichier commun neutre côté "nixos/".
# Pas de Home-Manager, pas de GTK ici pour éviter tout conflit.

{
  # Réglages système génériques sûrs
  programs.dconf.enable = true;
  security.polkit.enable = true;

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Xinput / touchpad
  services.libinput.enable = true;

  # Fonts basiques
  fonts = {
    fontDir.enable = true;
    packages = [
      pkgs.noto-fonts
      pkgs.noto-fonts-emoji
    ];
  };

  # Nix options safe
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    keep-outputs = true;
    keep-derivations = true;
  };

  # Configuration home-manager de base
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { 
      inherit inputs;
    };
    sharedModules = [
      { disabledModules = [ "services/mako" ]; }
    ];
  };

  # Ne RIEN définir ici concernant:
  # - home-manager.users.*
  # - gtk.theme / gtk3.theme
  # - pointerCursor
  # - xresources
}
