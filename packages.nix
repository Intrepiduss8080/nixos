
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
    nginx
    docker
    ruby.devEnv
    wezterm
  ];

  nixpkgs.config.allowUnfree = true;





  services.xserver.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

}
