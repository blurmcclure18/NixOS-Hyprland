{configs, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
	settings = {
		windowrule = [
			"suppressevent maximize, class:.*"
		        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
		        "tag +terminal, class:^(Alacritty)$"
		        "opacity 0.95 0.8, tag:terminal*"

			# windowrule v2 move to workspace
			"workspace 1, class:^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
			"workspace 2, class:^([Dd]iscord)$"
			"workspace 3, class:^([Ss]team)$"
			"workspace 4, class:^([Qq]utebrowser)$"
			
			# windowrule v2 - float
			"float, class:^(org.kde.polkit-kde-authentication-agent-1)$ "
			"float, class:([Tt]hunar), title:(File Operation Progress)"
			"float, class:([Tt]hunar), title:(Confirm to replace files)"
			"float, class:(xdg-desktop-portal-gtk)"
			"float, class:(org.gnome.Calculator), title:(Calculator)"
			"float, class:^([Rr]ofi)$"
			"float, class:^(pavucontrol|org.pulseaudio.pavucontrol)$"
			"float, class:^(nwg-look|qt5ct|qt6ct|mpv)$"
			"float, class:^(nm-applet|nm-connection-editor|blueman-manager)$"
			"float, class:^(gnome-system-monitor|org.gnome.SystemMonitor)$ # system monitor"
			"float, class:^(yad)$ # icon browser"
			"float, class:^(file-roller|org.gnome.FileRoller)$ # archive manager"
			"float, class:^([Bb]aobab|org.gnome.[Bb]aobab)$ # Disk usage analyzer"
			"float, title:(Kvantum Manager)"
			"float, class:^([Ss]team)$,title:^((?![Ss]team).*|[Ss]team [Ss]ettings)$"
			"float, class:^([Qq]alculate-gtk)$"
			
			# windowrule v2 - position
			"center, class:([Tt]hunar), title:(File Operation Progress)"
			"center, class:([Tt]hunar), title:(Confirm to replace files)"
			
			# windowrule v2 - opacity #enable as desired
			"opacity 0.9 0.6, class:^([Rr]ofi)$"
			"opacity 0.9 0.7, class:^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
			"opacity 0.9 0.8, class:^([Tt]hunar)$"
			"opacity 0.9 0.8, class:^(Alacritty)$"
			"opacity 0.9 0.8, class:^(Ghostty)$"
			"opacity 0.9 0.8, class:^(nwg-look|qt5ct|qt6ct|yad)$"
			"opacity 0.9 0.8, title:(Kvantum Manager)"
			"opacity 0.94 0.86, class:^([Dd]iscord|[Vv]esktop)$"
			"opacity 0.94 0.86, class:^(gnome-disks|evince|wihotspot-gui|org.gnome.baobab)$"
			"opacity 0.9 0.8, class:^(file-roller|org.gnome.FileRoller)$ # archive manager"
			"opacity 0.82 0.75, class:^(gnome-system-monitor|org.gnome.SystemMonitor)$"
			"opacity 0.9 0.8, class:^(xdg-desktop-portal-gtk)$ # gnome-keyring gui"
			
			# windowrule v2 - size
			"size 70% 70%, class:^(gnome-system-monitor|org.gnome.SystemMonitor)$"
			"size 70% 70%, class:^(xdg-desktop-portal-gtk)$"
			"size 60% 70%, title:(Kvantum Manager)"
			"size 60% 70%, class:^(qt6ct)$"
			"size 60% 70%, class:^(file-roller|org.gnome.FileRoller)$"
			
			# Picture-in-a-Picture (PIP) rules: Oddly, some need re-duplication.  This is because the window for
			# PIP changes after on first launch, and will not inherant the rules...
			"opacity 0.95 0.75,title:^(Picture-in-Picture)$"
			
			# Interestingly, the opacity rule above doesn't need the reduplication?
			"pin,title:^(Picture-in-Picture)$ "
			"float, title:^(Picture-in-Picture)$"
			"size 25% 25%,title:^(Picture-in-Picture)$ "
			"move 72% 7%,title:^(Picture-in-Picture)$ "
			
			#Steam WindowRules
			"float, class:^([Ss]team)$"
			"workspace 3 silent, class:^([Ss]team)$"
			"tile, class:^([Ss]team)$"
		];

		layerrule = [
			"unset,class:^([Rr]ofi)$"
			"blur,class:^([Rr]ofi)$"
			"ignorezero, <rofi>"
			"blur, rofi"
			
			"ignorezero, overview"
			"blur, overview"
			
			"ignorezero, <wlogout>"
			"blur, wlogout"
		];
	};
  };
}
