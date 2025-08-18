<div align="center">
  
  <img src="./assets/Agentic_NIXOS.png" alt="Agentic NixOS" width="350" style="margin: 20px 0;">
  
  # Agentic NixOS

  **A secure, AI-enhanced DevOps workstation built on NixOS + Hyprland**

  [![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
  [![Hyprland](https://img.shields.io/badge/Hyprland-00D9FF?style=for-the-badge&logo=wayland&logoColor=white)](https://hyprland.org)
  [![Security](https://img.shields.io/badge/Security-Hardened-red?style=for-the-badge)](/)
  [![AI](https://img.shields.io/badge/AI-Enhanced-purple?style=for-the-badge)](/)

</div>

---

## 📸 Screenshots

<div align="center">

### Desktop Environment
<img src="./assets/desktop-cyberpunk.png" alt="Desktop with Cyberpunk wallpaper" width="600">

### AI Integration & Terminal
<img src="./assets/terminal-gemini-fastfetch.png" alt="Terminal with Gemini CLI and Fastfetch" width="600">

### Clean Interface
<img src="./assets/desktop-clean.png" alt="Clean Hyprland interface" width="600">

</div>

---

## 🚀 What Makes This Special?

Fork of [**Sly-Harvey/NixOS**](https://github.com/Sly-Harvey/NixOS) enhanced with **production-ready security** and **AI-powered development tools**:

**🔒 Security First**: AppArmor + Firewall + Network hardening  
**🤖 AI Integration**: kubectl-ai, gemini-cli, codex for intelligent workflows  
**📦 Secure Containers**: Rootless Podman + Distrobox for isolated development  
**🎨 Beautiful Desktop**: Catppuccin theme with Hyprland compositor  
**⚡ DevOps Ready**: Complete K8s + Docker + Infrastructure tools  

---

## 🛠️ Development Stack

| Category | Tools | What They Do |
|----------|-------|--------------|
| **🤖 AI Agents** | kubectl-ai, gemini-cli, codex | Natural language → commands |
| **☸️ Kubernetes** | k3d, kubectl, helm, k9s | Local clusters + management |
| **🐳 Containers** | Docker, Podman (rootless), Distrobox | Secure isolated environments |
| **🔧 Infrastructure** | Terraform, Ansible, Jenkins | Infrastructure as Code |
| **💻 Development** | VSCode, Nixvim, 30+ dev-shells | Modern editing + language support |
| **🎨 Desktop** | Hyprland, Catppuccin, Waybar | Beautiful Wayland environment |

---

## 🔒 Security Features

### Built-in Protection
- **🛡️ Firewall**: Strict rules, only essential ports open
- **🔐 AppArmor**: Mandatory Access Control for process isolation
- **🚫 Network Hardening**: Anti-scan, SYN flood protection
- **👤 Rootless Containers**: No privileged processes
- **🔑 Sudo Protection**: Password required for admin actions

### What This Means for You
```bash
# Your containers run without root privileges
distrobox create fedora  # No sudo needed, fully isolated

# Firewall blocks unwanted connections automatically
# Only media server (DLNA) ports are open

# AI tools work safely in isolated environments
kubectl ai "create nginx deployment"  # Secure by design
```

---

## 📦 Container Architecture

**Why containers matter**: Traditional package managers can break NixOS. Our solution? Secure, persistent container environments.

### How It Works
```
You type: distrobox create ubuntu
    ↓
Podman creates rootless container
    ↓
Stored in ~/.local/share/containers/
    ↓
Install anything: apt, npm, pip, go get
    ↓
Survives NixOS rebuilds!
```

### Benefits
- **🔒 Secure**: No root access, user-isolated
- **📁 Persistent**: Containers survive reboots and system updates
- **🏠 Integrated**: Access your home directory naturally
- **🚀 Fast**: No sudo overhead

---

## 🤖 AI-Powered Workflow

Transform complex commands into natural language:

```bash
# Kubernetes made simple
kubectl ai "create a nginx deployment with 3 replicas"
kubectl ai "show me all failing pods"

# Google AI assistant
gemini-cli "explain kubernetes networking"
gemini-cli "write terraform for AWS EC2"

# Code generation
codex "create a python web scraper"
codex "write golang REST API"
```

**Setup**: Export `OPENAI_API_KEY` and `GEMINI_API_KEY` in your shell.

---

## 🎨 Theme System

- **Current**: Catppuccin Macchiato with Lavender accents
- **Wallpaper**: Cyberpunk (switchable to: moon, dark-forest, kurzgesagt, fog, train)
- **Consistency**: GTK4, Qt/Kvantum, Hyprland all match perfectly

**Switch themes**: Edit `flake.nix` line 49: `theme = "Dracula";`  
**Switch wallpaper**: Edit `flake.nix` line 51: `wallpaper = "moon";`

---

## 📁 Repository Structure

```
├── flake.nix                    # Main configuration (themes, user settings)
├── hosts/Default/configuration.nix  # System packages & security
├── modules/
│   ├── themes/Catppuccin/       # Theme configurations
│   ├── desktop/hyprland/        # Wayland compositor setup
│   ├── programs/                # Application configurations
│   └── hardware/                # Driver configurations
├── dev-shells/                  # 30+ development environments
└── assets/                      # Logo and wallpapers
```

---

## 🚀 Quick Start

```bash
# Clone and customize
git clone <your-repo-url>
cd nixos-config

# Update username in flake.nix
sed -i 's/username = "r3v4n"/username = "yourname"/' flake.nix

# Apply configuration
sudo nixos-rebuild switch --flake .#Default

# Create development environment
distrobox create --image ubuntu:22.04 dev-env
distrobox enter dev-env

# Use AI tools
kubectl ai "create kubernetes dashboard"
gemini-cli "explain this error message"
```

---

## 🌟 What's Included

### System Applications
- **Firefox** (hardened with Betterfox)
- **VSCode** (with extensions)
- **Obsidian** (note-taking)
- **Bitwarden** (password manager)
- **OBS Studio** (streaming)
- **GIMP & Inkscape** (graphics)

### Development Tools
- **Languages**: Node.js, Python, Go, Rust, Cargo
- **CLI Tools**: curl, jq, btop, nmap, tree, rsync
- **Git & GitHub**: Enhanced workflows
- **Media Server**: DLNA for streaming content

### Performance Optimizations
- **SSD-friendly**: Low swappiness (10%)
- **I/O optimized**: Tuned dirty ratios
- **Memory efficient**: Smart caching strategies

---

## 🔧 Customization

1. **Change user**: Edit `username` in `flake.nix`
2. **Switch editor**: Change `editor = "nixvim"` to `"vscode"`
3. **Pick terminal**: Set `terminal = "kitty"` or `"alacritty"`
4. **Graphics driver**: Adjust `videoDriver = "nvidia"` for your hardware

---

## 🛡️ Security Philosophy

**Defense in Depth**: Multiple security layers protect your work:
- Firewall blocks unauthorized access
- AppArmor isolates applications
- Rootless containers prevent privilege escalation
- Network hardening stops common attacks
- Password-protected admin access

**Zero Trust Containers**: Every development environment runs without privileges, ensuring that even compromised containers can't damage your system.

---

<div align="center">
  
  **📄 License**: [LICENSE](./LICENSE)  
  **🌟 Based on**: [Sly-Harvey/NixOS](https://github.com/Sly-Harvey/NixOS)  
  **🔒 Security**: Hardened for production use  
  **🤖 AI**: Enhanced with intelligent tools  
  
</div>