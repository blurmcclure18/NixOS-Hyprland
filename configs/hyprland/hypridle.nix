{config, pkgs, ... }:
{
  home.file.".config/hypr/hypridle.conf".text = ''

      general {
        lock_cmd = pidof hyprlock || hyprlock
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch dpms on
        ignore_dbus_inhibit = false
      }
      listener {
        timeout = 840
        on-timeout = $HOME/.config/hypr/scripts/hypridle-notify.sh --warn
        on-resume = $HOME/.config/hypr/scripts/hypridle-notify.sh --resume
        }
      listener {
        timeout = 900
        on-timeout = loginctl lock-session & systemctl suspend
        }
    '';
}

#loginctl lock-session

