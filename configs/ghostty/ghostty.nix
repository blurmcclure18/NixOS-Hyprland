{configs, pkgs, ... }:
{
  programs.ghostty = {
	enable = true;

	settings = {
	  font-family = "CaskaydiaMono Nerd Font";
	  theme = "wallust";
	  background-opacity = 0.9;
	  confirm-close-surface = false;

	  window-padding-x = 14;
	  window-padding-y = 14;
	};
  };
}
