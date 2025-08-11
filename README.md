<div align="center">
  
  <img src="./assets/Agentic_NIXOS.png" alt="Agentic NixOS" width="350" style="margin: 20px 0;">
  
  # Agentic NixOS
  
  **DevOps workstation based on NixOS + Hyprland with curated toolchain and AI agents**
  
  [![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
  [![Hyprland](https://img.shields.io/badge/Hyprland-00D9FF?style=for-the-badge&logo=wayland&logoColor=white)](https://hyprland.org)
  [![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com)
  [![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io)
  
</div>

---

## 📋 About

Fork of [**Sly-Harvey/NixOS**](https://github.com/Sly-Harvey/NixOS) (NixOS + Hyprland desktop) enhanced with:

**🔧 DevOps Toolchain**: Terraform • Docker • Ansible • Helm • k3d • Git • k9s  
**🎨 Enhanced Themes**: Extended theming system with custom wallpapers  
**🤖 AI Agents**: Optional intelligent automation for infrastructure workflows  

---

## 🚀 Quick Start

```bash
# Apply configuration
sudo nixos-rebuild switch --flake .#Default

# Create local Kubernetes lab
k3d cluster create lab --servers 1 --agents 1 --wait
kubectl get nodes
```

---

## 🛠️ DevOps Tools Added

| Tool | Purpose | Example |
|------|---------|---------|
| **Terraform** | Infrastructure as Code | `terraform plan/apply` |
| **Docker** | Containerization | Auto-configured with user permissions |
| **Ansible** | Configuration management | `ansible-playbook deploy.yml` |
| **Helm** | Kubernetes package manager | `helm install nginx nginx/` |
| **k3d** | Local Kubernetes clusters | `k3d cluster create lab` |
| **Git** | Version control | Enhanced workflows |
| **k9s** | Kubernetes visualization | Terminal K8s dashboard |

---

## 🎨 New Themes

- **Custom wallpaper**: `Agentic_NIXOS.jxl` with theme integration
- **Available themes**: Catppuccin • Dracula • Rosé Pine
- **Consistent styling**: Desktop, lock screen, and all components match

**Switch theme**: Edit `modules/desktop/hyprland/default.nix`

---

## 🤖 AI Agents

Optional automation scripts for infrastructure workflows. Place API keys in `~/.config/agentic_nixos/.env`.

### **🛡️ Orion - Infrastructure Reviewer**
```bash
scripts/agents/orion.sh review terraform ./infrastructure/
```
Reviews Terraform/Ansible code for security vulnerabilities and best practices.

### **🔍 Sentry - Kubernetes Guardian**
```bash
scripts/agents/sentry.sh audit --namespace production
```
Monitors cluster security, RBAC misconfigurations, and compliance.

### **⚔️ Aegis - Security Scanner**
```bash
scripts/agents/aegis.sh scan image nginx:latest
```
Orchestrates vulnerability scanning with Trivy, Grype, and SBOM generation.

### **💬 Hermes - CLI Assistant**
```bash
scripts/agents/hermes.sh "deploy app to kubernetes with HA"
```
Generates CLI commands from natural language and troubleshoots issues.

### **🗺️ Cartographer - Documentation**
```bash
scripts/agents/cartographer.sh map --cluster lab --output docs/
```
Auto-generates architecture diagrams and documentation from infrastructure.

---

## 📁 Structure

```
├─ flake.nix                        # Main configuration
├─ hosts/Default/configuration.nix  # DevOps tools & services
├─ modules/themes/                  # Catppuccin, Dracula, rose-pine
├─ scripts/agents/                  # AI automation scripts
└─ assets/Agentic_NIXOS.png        # Logo
```

---

<div align="center">
  
  **📄 License**: [LICENSE](./LICENSE)  
  **🌟 Based on**: [Sly-Harvey/NixOS](https://github.com/Sly-Harvey/NixOS)  
  
</div>
