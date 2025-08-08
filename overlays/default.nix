cd ~/nixos-config

cat > overlays/default.nix <<'NIX'
{ inputs, settings, ... }:
{
  # Keep your local additions
  additions = final: _prev:
    import ../pkgs {
      pkgs = final;
      settings = settings;
    };

  # Only apply NUR + provide a stable channel, no Hydenix
  modifications = final: prev:
    let
      withNur = inputs.nur.overlays.default final prev;
    in
      withNur // {
        stable = import inputs.nixpkgs-stable {
          system = final.system;
          config.allowUnfree = true;
        };
      };
}
NIX

git add overlays/default.nix
git commit -m "Drop Hydenix from overlay; keep NUR + stable"
sudo nixos-rebuild switch --flake .#Default --show-trace
