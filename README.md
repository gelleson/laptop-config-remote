# macOS Configuration with Nix and Nix Darwin

This repository provides a comprehensive setup for configuring macOS using Nix and Nix Darwin. It streamlines the installation process and helps manage system configurations efficiently.

## Table of Contents

- [Quick Start](#quick-start)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Manual Installation](#manual-installation)
  - [1. Installing Nix](#1-installing-nix)
  - [2. Configuring Nix](#2-configuring-nix)
  - [3. Installing Nix Darwin](#3-installing-nix-darwin)
  - [4. Cloning the Configuration](#4-cloning-the-configuration)
  - [5. Activating the Configuration](#5-activating-the-configuration)
- [Usage](#usage)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Quick Start

For a quick setup, run these commands in sequence:

1. Install Homebrew and Nix:

   ```bash
   curl -L https://raw.githubusercontent.com/gelleson/laptop-config-remote/refs/heads/master/install.sh | bash -s install
   ```

2. Fetch the configuration and ensure nix.conf:

   ```bash
   curl -L https://raw.githubusercontent.com/gelleson/laptop-config-remote/refs/heads/master/install.sh | bash -s config
   ```

3. Install Nix Darwin and activate the configuration:
   ```bash
   curl -L https://raw.githubusercontent.com/gelleson/laptop-config-remote/refs/heads/master/install.sh | bash -s activate
   ```

## Features

- Easy installation of Nix package manager
- Configuration management using Nix Darwin
- Homebrew integration for additional package management
- Customizable system settings and user environment
- Pre-configured development tools and utilities
- Shell enhancements with Zsh and useful aliases

## Prerequisites

- macOS (tested on macOS Monterey and later)
- Administrative access to your machine
- Internet connection for downloading packages

## Manual Installation

If you prefer to install manually or want more control over the process, follow these steps:

### 1. Installing Nix

Install the Nix package manager:

```bash
sh <(curl -L https://nixos.org/nix/install)
```

### 2. Configuring Nix

Create or edit `/etc/nix/nix.conf`:

```bash
sudo mkdir -p /etc/nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
```

### 3. Installing Nix Darwin

Build and install Nix Darwin:

```bash
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```

### 4. Cloning the Configuration

Clone this repository:

```bash
git clone https://github.com/gelleson/laptop-config-remote.git ~/.config/nix-darwin
```

### 5. Activating the Configuration

Apply the configuration:

```bash
darwin-rebuild switch --flake ~/.config/nix-darwin#my-mac
```

## Usage

After installation, you can use the following commands:

- Update and rebuild the system: `updos`
- Edit configuration: `updos-edit`
- List files: `ls` (uses `eza`)
- Detailed file listing: `ll`
- View file contents: `cat` (uses `bat`)
- Update LLM plugins: `llm-update-plugins`

## Customization

To customize your setup:

1. Edit files in `~/.config/nix-darwin/modules/`
2. Modify `flake.nix` to add or remove modules
3. Run `updos` to apply changes

## Troubleshooting

If you encounter issues:

1. Ensure Nix and Homebrew are in your PATH
2. Check for error messages in the terminal output
3. Verify that all prerequisites are met
4. Try running `nix flake update` in the `~/.config/nix-darwin/` directory

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/YourFeature`)
3. Make your changes
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin feature/YourFeature`)
6. Create a new Pull Request

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

For more information or support, please open an issue on the GitHub repository.
