## 🚀 Quick Start

Paste this into your terminal and hit enter:

```bash
curl -fsSL https://raw.githubusercontent.com/1momoh/1-click-Shelby-CLI-installer/main/shelby-install.sh | bash
```

That's it. The script handles everything else.

> 💡 **Tip:** The script will ask you a few questions during setup — select **`y`** (yes) for everything to get the full automatic installation.

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

Once the script finishes, **open a fresh terminal window** and follow these steps in order:

---

**Step 1 — Initialize the Shelby CLI**

> ⚠️ This must be run in a **new terminal window** — it won't work inside the installer script.

```bash
shelby init
```

This creates your Shelby config file at `~/.shelby/config.yaml`. Follow the prompts — you can accept the defaults.

---

**Step 2 — Configure your dev account**

```bash
cd shelby-quickstart
npm run config
```

---

**Step 3 — Set up your Aptos wallet**

> ⚠️ **This is NOT an EVM chain.** Do NOT use MetaMask or any EVM wallet.

You need an **Aptos wallet**. We recommend **Petra** — the official Aptos wallet extension:

👉 [Install Petra Aptos Wallet (Chrome)](https://chromewebstore.google.com/detail/petra-aptos-wallet/ejjladinnckdgjemekebdpeokbikhfci?hl=en-US&utm_source=ext_sidebar)

---

**Step 4 — Fund your dev address**

Once your wallet is set up, grab testnet tokens from the faucets:
- ShelbyUSD Faucet → https://docs.shelby.xyz/apis/faucet/shelbyusd
- Aptos Faucet → https://docs.shelby.xyz/apis/faucet/aptos

---

**Step 5 — Try the CLI commands**

```bash
npm run upload     # Upload a blob to Shelby
npm run list       # List blobs for an account
npm run download   # Download a blob to local filesystem
npm run dev        # Watch mode for active development
```

---

## 🔗 Resources

- 📖 Shelby Docs — https://docs.shelby.xyz/tools/cli
- 📄 Shelby Whitepaper — https://shelby.xyz/whitepaper.pdf
- 🔵 Original Quickstart Repo — https://github.com/shelby/shelby-quickstart

---

## 💬 My Community

- Telegram: [t.me/Labs87](https://t.me/Labs87)
- Twitter/X: [@ofalamin](https://x.com/ofalamin)

---

> ⚠️ **Security note:** Never use real private keys or seed phrases during development. Use test accounts only. See the [Shelby CLI guide](https://docs.shelby.xyz/tools/cli) for proper secret management in production.

---

<p align="center">
  Made with 🌵 by .87
</p>
