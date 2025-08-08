{ inputs, settings, ... }:
{
  # Overlay custom derivations into nixpkgs so you can use pkgs.<name>
  additions = final: _prev:
    import ../pkgs {
      pkgs = final;
      settings = settings;
    };

  # https://wiki.nixos.org/wiki/Overlays
  # ➜ On compose l’overlay Hydenix dans "modifications"
  modifications = final: prev:
    let
      hydenixOverlay = inputs.hydenix.overlays.default;
      # appliquer l’overlay hydenix pour obtenir ses ajouts
      hydenixPkgs = hydenixOverlay final prev;
    in
    hydenixPkgs // {
      # tes modifs/ajouts existants
      nur = inputs.nur.overlays.default;

      stable = import inputs.nixpkgs-stable {
        system = final.system;
        config.allowUnfree = true;
      };
    };
}
