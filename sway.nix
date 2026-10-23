{pkgs, lib, ...}: {
	

	environment.systemPackages = with pkgs; [
		wl-clipboard
		mako
		waybar

	];
 	
     # Enables Gnome Keyring to store secrets for applications. 
  services.gnome.gnome-keyring.enable = true;

  # Enable Sway.
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  
  
  programs.waybar.enable = true;




}
