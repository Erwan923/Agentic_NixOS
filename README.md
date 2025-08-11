cd ~/nixos-config
mkdir -p assets
cp -f ~/Pictures/Agentic_NIXOS.png assets/

cat > README.md <<'EOF'
<div align="center">
  <img src="./assets/Agentic_NixOS.png" alt="Agentic NixOS" width="280">
  
  # Agentic NixOS
  
  **Reproducible DevOps/DevSecOps workstation on NixOS + Hyprland, with optional AI agents.**
  
  [![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=flat-square&logo=nixos&logoColor=white)](https://nixos.org)
  [![Hyprland](https://img.shields.io/badge/Hyprland-00D9FF?style=flat-square&logo=wayland&logoColor=white)](https://hyprland.org)
  [![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)](https://docker.com)
  [![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white)](https://kubernetes.io)
  
</div>

---

> **📋 Upstream**: Fork of [**Sly-Harvey/NixOS**](https://github.com/Sly-Harvey/NixOS) with full DevOps toolchain (**Ansible**, **Terraform**, **k3d**, **kubectl**, **Helm**, **k9s**, **Git**, **jq**), Docker enablement, one-command K8s, versioned wallpaper, and polished UX.

## 🚀 TL;DR

```bash
# Apply system (hostname "Default")
sudo nixos-rebuild switch --flake .#Default

# Local Kubernetes with k3d
k3d cluster create dev --servers 1 --agents 1 --wait
kubectl get nodes
