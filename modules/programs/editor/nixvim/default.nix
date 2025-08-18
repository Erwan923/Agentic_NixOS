{
  inputs,
  pkgs,
  lib,
  ...
}: {
  home-manager.sharedModules = [
    (_: {
      home.packages = [
        # Re-enable nixvim with Sly-Harvey configuration
        inputs.nixvim.packages.${pkgs.system}.default
      ];
    })
  ];
}
