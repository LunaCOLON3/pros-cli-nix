# pros-nix-template

This is a nix package an template for the [pros-cli](https://github.com/purduesigbots/pros-cli/tree/develop).

This gives you a pinned version of pros-cli and ARM toolchain that can be shared between all developers of the project, meaning that each development environment will be identical (mostly).

## Getting Started

The first thing you'll need to do is install Nix.

Nix is available for ~~all~~ most linux distros, macOS and is even a standalone distro! If you want to use windows, use WSL.
To get started install nix with your package manager:
```sh
# Arch Linux
sudo pacman -S nix

# Works on most distros
sh <(curl -L https://nixos.org/nix/install) --daemon

# MacOS
$ sh <(curl -L https://nixos.org/nix/install) --no-daemon
```
More info here:
https://nixos.org/download.html

Then cd into the directory you want in you terminal and run:
```sh
nix flake init --template github:BattleCh1cken/pros-cli-nix#default
nix develop
pros c n $(pwd)
```

If your interesting in learning more look here:

https://nixos.org/manual/nix/unstable/

Happy coding!
