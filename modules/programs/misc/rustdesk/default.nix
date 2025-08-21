{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rustdesk
  ];

  # Configuration firewall pour RustDesk
  networking.firewall = {
    allowedTCPPorts = [ 21115 21116 21117 21118 21119 ];
    allowedUDPPorts = [ 21116 ];
  };
}