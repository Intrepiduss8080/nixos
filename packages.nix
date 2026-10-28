{ pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    go
    htop
    wget
    tmux
    btop
    kitty
    clang
    picom
    floorp-bin
    elixir
    php 
    lua
    nginx
    docker
    ruby.devEnv
    wezterm
    zig
    xclip
    wl-clipboard
    postgresql
    docker
  ];



    nixpkgs.config.allowUnfree = true;

    services.nginx.enable = true;


    services.xserver.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
}
