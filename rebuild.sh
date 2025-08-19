#!/usr/bin/env bash
# Script de rebuild NixOS

set -euo pipefail

FLAKE_DIR="/home/r3v4n/nixos-config"
HOST="Default"

cd "$FLAKE_DIR"

# Première fois : --install-bootloader
# Après : juste switch suffit
if [[ "${1:-}" == "--first-time" ]] || [[ "${1:-}" == "--fix-bootloader" ]]; then
    echo "🔄 (Re)configuration bootloader..."
    sudo nixos-rebuild switch --flake "$FLAKE_DIR#$HOST" --install-bootloader --show-trace
    echo "✅ Bootloader configuré ! Prochaines fois : ./rebuild.sh"
else
    echo "🔄 Mise à jour configuration..."
    sudo nixos-rebuild switch --flake "$FLAKE_DIR#$HOST" --show-trace
    echo "✅ Configuration mise à jour !"
fi