# ⚡ Shelby Quickstart — 1-Click Installer

> A single command to get you up and running with the Shelby CLI — no manual setup, no headaches.

Built by [.87🌵](https://x.com/ofalamin) · Community: [t.me/Labs87](https://t.me/Labs87) · Twitter/X: [@ofalamin](https://x.com/ofalamin)

---

## 🚀 Quick Start

Paste this into your terminal and hit enter:

```bash
curl -fsSL https://raw.githubusercontent.com/1momoh/1-click-Shelby-CLI-installer/main/shelby-install.sh | bash
```

That's it. The script handles everything else.

---

## 🛠️ What It Does

The installer walks you through the full setup automatically:

| Step | What happens |
|------|-------------|
| ✅ OS Check | Confirms you're on Linux or macOS |
| ✅ Git | Verifies git is available |
| ✅ Node.js v22+ | Checks version — auto-installs via nvm if missing |
| ✅ Package Manager | Detects pnpm (preferred) or npm |
| ✅ Shelby CLI | Auto-installs via `npm install -g @shelby-protocol/cli` if missing |
| ✅ Aptos CLI | Auto-installs via Homebrew (macOS) or Python script (Linux) if missing |
| ✅ Clone & Build | Clones the quickstart repo and builds it |
| ✅ Config Prompt | Optionally launches `npm run config` to set up your dev account |

---

## 📋 Requirements

- **OS:** Linux or macOS
- **Node.js:** v22 or later *(auto-installed via nvm if missing)*
- **python3:** required on Linux for Aptos CLI install *(usually pre-installed)*
- **Shelby CLI** — auto-installed by the script, or manually: `npm install -g @shelby-protocol/cli`
- **Aptos CLI** — auto-installed by the script, or manually: [Install guide](https://aptos.dev/build/cli)

---

## 🧪 After Installation

Once the script completes, you'll be inside the `shelby-quickstart` directory and ready to go.

**1. Fund your dev address**
- ShelbyUSD Faucet → https://docs.shelby.xyz/apis/faucet/shelbyusd
- Aptos Faucet → https://docs.shelby.xyz/apis/faucet/aptos

**2. Try the CLI commands**

```bash
cd shelby-quickstart

npm run config     # Set up your dev account + .env
npm run upload     # Upload a blob to Shelby
npm run list       # List blobs for an account
npm run download   # Download a blob to local filesystem
npm run dev        # Watch mode for active development
```

---

## 📁 Files

```
.
├── shelby-install.sh   # 1-click installer script
└── README.md           # This file
```

---

## 🔗 Resources

- 📖 Shelby Docs — https://docs.shelby.xyz/tools/cli
- 📄 Shelby Whitepaper — https://shelby.xyz/whitepaper.pdf
- 🔵 Original Quickstart Repo — https://github.com/shelby/shelby-quickstart

---

## 💬 Community

Built something cool with Shelby? Come share it.

- Telegram: [t.me/Labs87](https://t.me/Labs87)
- Twitter/X: [@ofalamin](https://x.com/ofalamin)

---

> ⚠️ **Security note:** Never use real private keys or seed phrases during development. Use test accounts only. See the [Shelby CLI guide](https://docs.shelby.xyz/tools/cli) for proper secret management in production.

---

<p align="center">
  Made with 🌵 by .87
</p>
