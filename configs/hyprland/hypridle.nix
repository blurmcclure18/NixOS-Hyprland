{config, pkgs, ... }:
{
  services.hypridle = {
    enable = true;
  };

  home.file.".config/hypr/hypridle.conf".text = ''

      general {
        lock_cmd = pidof hyprlock || hyprlock
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch dpms on
        ignore_dbus_inhibit = false
      }
      listener {
        timeout = 540
        on-timeout = $HOME/.config/hypr/scripts/hypridle-notify.sh --warn
        on-resume = $HOME/.config/hypr/scripts/hypridle-notify.sh --resume
        }
      listener {
        timeout = 600
        on-timeout = loginctl lock-session
      }
    '';
}
