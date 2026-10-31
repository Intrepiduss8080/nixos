<p align="center">
  <img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/97444e18b7fe97705e8caedd29ae05e62cb5d4b7/wallpapers/nixos-wallpaper-catppuccin-macchiato.png" alt="NixOS" width="1000">
</p>


# nixos-config

This is a usual config for starting using NixOS.
All files of config NixOS are located in etc/nixos/.


> [!IMPORTANT] 
> Main step
>
> If you downloaded the OS via the installer, then open termninal and execute a few commands:



```bash

mkdir -p nix_ready_config

nix shell nixpkgs#git -c bash -c '
git clone https://github.com/Intrepiduss8080/nixos.git nix_ready_config/'


rm -f nix_ready_config/hardware-configuration.nix 

sudo cp -r /etc/nixos /etc/nixos.bak

sudo cp -r nix_ready_config/. /etc/nixos/

sudo nixos-rebuild switch

```


## What's inside.

In this repo I add a some programms for IT-people or someone, who just want try this distros. 

So, my config contains nvim, git, vim, jetbrains fonts, zsh, docker and many other casual programs + sway and + cinnamon.


> [!WARNING] 
>  Hardware-configuration.nix 
>
>This file is unique to each PC's. Dont copy this file, this step could break you system. You just need know this, you don't need to do anything there. 

