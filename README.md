# 🔒 Safe Mode Boot Manager

![Batch Script](https://img.shields.io/badge/script-batch-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows-0078D4.svg)
![Admin](https://img.shields.io/badge/requires-Admin-red.svg)

A smart Windows batch script that simplifies restarting into Safe Mode or back to Normal Mode. Automatically detects whether you're currently in Safe Mode or Normal Mode and presents only the relevant options. No more mashing F8!

# *⚠️To get back to normal mode, run the script again inside safe mode*

## ✨ Features

- 🧠 **Smart detection** - knows if you're in Safe Mode or Normal Mode
- 🔄 **One-click restart** - no need to remember bcdedit commands
- 🌐 **Network support** - choose Minimal Safe Mode or with Networking
- ⏱️ **5-second delay** - gives you time to cancel if needed
- 🛡️ **Admin check** - verifies elevated permissions before proceeding

  <img width="360" height="243" alt="image" src="https://github.com/user-attachments/assets/aae416e0-7762-4464-98f4-5d0d25038a99" />


## 🚀 Quick Start

1. **Run as Administrator** (right-click → "Run as administrator")

2. Select your desired boot option:


## 📋 Menu Options Explained

| Option | What It Does |
|--------|---------------|
| **Normal Mode** | Standard Windows boot with all drivers and services |
| **Safe Mode (Minimal)** | Basic safe mode with only essential drivers |
| **Safe Mode with Networking** | Safe mode + network drivers (for internet access) |

## ⚙️ How It Works

The script uses:

- **Registry check** (`SafeBoot\Option`) to detect if currently in Safe Mode
- **Admin check** (`net session`) to verify administrator privileges
- **BCDEdit commands** to configure the next boot mode:

```batch
# Set Safe Mode (Minimal)
bcdedit /set {current} safeboot minimal

# Set Safe Mode with Networking
bcdedit /set {current} safeboot network

# Remove Safe Mode (boot Normal)
bcdedit /deletevalue {current} safeboot
```

## ⚠️ Requirements

- **Administrator privileges** (must run as admin)
- Windows Vista / 7 / 8 / 10 / 11
- No additional software required

## 🎯 Common Use Cases

- 🖥️ **SFC /Scannow commands** - better functioning of sfc and DISM commands
- 🐛 **Troubleshooting driver issues** - boot into Safe Mode to uninstall problematic drivers
- 🦠 **Malware removal** - run antivirus scans in Safe Mode
- 🔧 **System restore** - perform restore points without interfering processes
- 💻 **Fixing boot problems** - access Safe Mode to run diagnostic tools
- 🎮 **Removing stubborn software** - uninstall programs that won't uninstall normally

## 💡 Pro Tips

- The 5-second countdown lets you cancel with **Ctrl+C** if you change your mind
- Keep this script on your desktop or USB drive for emergency troubleshooting
- Safe Mode with Networking is great for downloading drivers or fixes while troubleshooting
## 📝 Notes

- Windows 10/11 may have disabled the traditional F8 boot menu - this script is the reliable way to enter Safe Mode
- The script automatically detects your current mode and shows appropriate options
- Changes are temporary - after booting, the next restart will follow normal boot behavior
