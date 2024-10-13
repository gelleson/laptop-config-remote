# macOS Configuration with Nix and Nix Darwin

This repository provides a comprehensive setup for configuring macOS using Nix and Nix Darwin. It streamlines the installation process and helps manage system configurations efficiently.

1. **Install Homebrew and Nix**:

```bash
 curl -L https://raw.githubusercontent.com/gelleson/laptop-config-remote/refs/heads/master/install.sh | bash -s install
```

2. Fetch the configuration and ensure nix.conf:

```
curl -L https://raw.githubusercontent.com/gelleson/laptop-config-remote/refs/heads/master/install.sh | bash -s config
```

3. Install Nix Darwin and activate the configuration:

```bash
curl -L https://raw.githubusercontent.com/gelleson/laptop-config-remote/refs/heads/master/install.sh | bash -s activate
```

If you prefer to follow a manual installation process, please refer to the **Installation** section below for detailed steps.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Installing NixOS](#installing-nixos)
  - [Preparing Nix Configuration](#preparing-nix-configuration)
  - [Installing Nix Darwin](#installing-nix-darwin)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Features

- Easy installation of Nix package manager.
- Configuration management using Nix Darwin.
- Customizable settings for personal or team use.

## Prerequisites

Before you begin, ensure you have the following:

- A macOS system.
- Terminal access.

## Installation

### Installing NixOS

To install the Nix package manager, run the following command in your terminal:

```bash
curl -L https://nixos.org/nix/install | sh
```

This command downloads and executes the installation script for Nix.

### Preparing Nix Configuration

After installing Nix, you need to copy the configuration file to the appropriate directory:

```bash
cp ~/.config/nix-darwin/codes/nix.conf /etc/nix/
```

This step ensures that your custom `nix.conf` settings are applied.

### Installing Nix Darwin

To install Nix Darwin, build it from the source:

```bash
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
```

Then, run the installer:

```bash
./result/bin/darwin-installer
```

Finally, copy your Zsh profile settings:

```bash
cp ~/.config/nix-darwin/codes/.zprofile ~/.zprofile
```

## Usage

Once installed, you can manage packages and configurations using Nix and Nix Darwin. For example, you can run:

```bash
darwin-rebuild switch --flake ~/.config/nix-darwin#my-mac
```

This command activates your configuration.

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature/YourFeature`).
6. Open a Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to replace placeholders like `YourFeature` with actual information relevant to your project. This README provides a clear structure for users to understand what your project is about and how to use it effectively!
