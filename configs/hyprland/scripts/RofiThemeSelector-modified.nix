{configs, pkgs, ... }:

{
  home.file.".config/hypr/scripts/RofiThemeSelector-modified.sh" = {
    executable = true;
    text = builtins.replaceStrings ["__DOLLAR__"] ["$"] '' 
      #!/bin/sh
      # /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
      # A modified version of Rofi-Theme-Selector, concentrating only on ~/.local and also, applying only 10 @themes in ~/.config/rofi/config.rasi
      # as opposed to continous adding of //@theme
      
      # This code is released in public domain by Dave Davenport <qball@gmpclient.org>
      
      #iDIR="__DOLLAR__HOME/.config/swaync/images"
      
      
      OS="linux"
      
      ROFI=__DOLLAR__(command -v rofi)
      SED=__DOLLAR__(command -v sed)
      MKTEMP=__DOLLAR__(command -v mktemp)
      #NOTIFY_SEND=__DOLLAR__(command -v notify-send)
      
      if [ -z "__DOLLAR__{SED}" ]
      then
          echo "Did not find 'sed', script cannot continue."
          exit 1
      fi
      if [ -z "__DOLLAR__{MKTEMP}" ]
      then
          echo "Did not find 'mktemp', script cannot continue."
          exit 1
      fi
      if [ -z "__DOLLAR__{ROFI}" ]
      then
          echo "Did not find rofi, there is no point to continue."
          exit 1
      fi
      #if [ -z "__DOLLAR__{NOTIFY_SEND}" ]
      #then
      #    echo "Did not find 'notify-send', notifications won't work."
      #fi
      
      TMP_CONFIG_FILE=__DOLLAR__(__DOLLAR__{MKTEMP}).rasi
      #rofi_theme_dir="__DOLLAR__{HOME}/.local/share/rofi/themes"
      rofi_config_file="__DOLLAR__{XDG_CONFIG_HOME:-__DOLLAR__{HOME}/.config}/rofi/config.rasi"
      
      ##
      # Array with parts to the found themes.
      # And array with the printable name.
      ##
      declare -a themes
      declare -a theme_names
      
      ##
      # Function that tries to find all installed rofi themes.
      # This fills in #themes array and formats a displayable string #theme_names
      ##
      # Find themes in defined directories
      find_themes() {
          directories=("__DOLLAR__HOME/.local/share/rofi/themes" "__DOLLAR__HOME/.config/rofi/themes")
          
          for TD in "__DOLLAR__{directories[@]}"; do
              if [ -d "__DOLLAR__TD" ]; then
                  echo "Checking themes in: __DOLLAR__TD"
                  for file in "__DOLLAR__TD"/*.rasi; do
                      if [ -f "__DOLLAR__file" ] && [ ! -L "__DOLLAR__file" ]; then
                          themes+=("__DOLLAR__file")
                          theme_names+=("__DOLLAR__(basename "__DOLLAR__{file%.*}")")
                      else
                          echo "Skipping symlink: __DOLLAR__file"
                      fi
                  done
              else
                  echo "Directory does not exist: __DOLLAR__TD"
              fi
          done
      }
      
      ##
      # Function to add or update theme in the config.rasi
      ##
      add_theme_to_config() {
          local theme_name="__DOLLAR__1"
          local theme_path
      
          # Determine the correct path for the theme
          if [[ -f "__DOLLAR__HOME/.local/share/rofi/themes/__DOLLAR__theme_name.rasi" ]]; then
              theme_path="__DOLLAR__HOME/.local/share/rofi/themes/__DOLLAR__theme_name.rasi"
          elif [[ -f "__DOLLAR__HOME/.config/rofi/themes/__DOLLAR__theme_name.rasi" ]]; then
              theme_path="__DOLLAR__HOME/.config/rofi/themes/__DOLLAR__theme_name.rasi"
          else
              echo "Theme not found: __DOLLAR__theme_name"
              return 1
          fi
      
          # Resolve symlinks if present
          if [[ -L "__DOLLAR__theme_path" ]]; then
              theme_path=__DOLLAR__(readlink -f "__DOLLAR__theme_path")
          fi
      
          # Convert path to use ~ for home directory
          theme_path_with_tilde="~__DOLLAR__{theme_path#__DOLLAR__HOME}"
      
          # Add or update @theme line in config
          if ! grep -q '^\s*@theme' "__DOLLAR__rofi_config_file"; then
              echo -e "\n\n@theme \"__DOLLAR__theme_path_with_tilde\"" >> "__DOLLAR__rofi_config_file"
              echo "Added @theme \"__DOLLAR__theme_path_with_tilde\" to __DOLLAR__rofi_config_file"
          else
              __DOLLAR__SED -i "s/^\(\s*@theme.*\)/\/\/\1/" "__DOLLAR__rofi_config_file"
              echo -e "@theme \"__DOLLAR__theme_path_with_tilde\"" >> "__DOLLAR__rofi_config_file"
              echo "Updated @theme line to __DOLLAR__theme_path_with_tilde"
          fi
      
          # Limit the number of @theme lines to a maximum of 9
          max_lines=9
          total_lines=__DOLLAR__(grep -c '^\s*//@theme' "__DOLLAR__rofi_config_file")
      
          if [ "__DOLLAR__total_lines" -gt "__DOLLAR__max_lines" ]; then
              excess=__DOLLAR__((total_lines - max_lines))
              for i in __DOLLAR__(seq 1 "__DOLLAR__excess"); do
                  __DOLLAR__SED -i '0,/^\s*\/\/@theme/ { /^\s*\/\/@theme/ {d; q; }}' "__DOLLAR__rofi_config_file"
              done
              echo "Removed excess //@theme lines"
          fi
      }
      
      ##
      # Create a copy of rofi config
      ##
      create_config_copy()
      {
          __DOLLAR__{ROFI} -dump-config > "__DOLLAR__{TMP_CONFIG_FILE}"
          # remove theme entry.
          __DOLLAR__{SED} -i 's/^\s*theme:\s\+".*"\s*;//g' "__DOLLAR__{TMP_CONFIG_FILE}"
      }
      
      ###
      # Print the list out so it can be displayed by rofi.
      ##
      create_theme_list()
      {
          OLDIFS=__DOLLAR__{IFS}
          IFS='|'
          for themen in __DOLLAR__{theme_names[@]}
          do
              echo "__DOLLAR__{themen}"
          done
          IFS=__DOLLAR__{OLDIFS}
      }
      
      ##
      # Thee indicate what entry is selected.
      ##
      declare -i SELECTED
      
      source $HOME/.config/hypr/wallust/wallust-hypridle.conf

      notify_change() {
      
          notify_color=__DOLLAR__color3
          
          # Confirm visually
          hyprctl dismissnotify && hyprctl notify -1 10000 "__DOLLAR__notify_color" "fontsize:15 Rofi Theme Set: Theme changed to: __DOLLAR__selection"
      }
      
      select_theme()
      {
          local MORE_FLAGS=(-dmenu -format i -no-custom -p "Theme" -markup -config "__DOLLAR__{TMP_CONFIG_FILE}" -i)
          MORE_FLAGS+=(-kb-custom-1 "Alt-a")
          MORE_FLAGS+=(-u 2,3 -a 4,5 )
          local CUR="default"
          while true
          do
              declare -i RTR
              declare -i RES
              local MESG="""You can preview themes by hitting <b>Enter</b>.
      <b>Alt-a</b> to accept the new theme.
      <b>Escape</b> to cancel
      Current theme: <b>__DOLLAR__{CUR}</b>
      <span weight=\"bold\" size=\"xx-small\">When setting a new theme this will override previous theme settings.
      Please update your config file if you have local modifications.</span>"""
              THEME_FLAG=
              if [ -n "__DOLLAR__{SELECTED}" ]
              then
                  THEME_FLAG="-theme __DOLLAR__{themes[__DOLLAR__{SELECTED}]}"
              fi
              RES=__DOLLAR__( create_theme_list | __DOLLAR__{ROFI} __DOLLAR__{THEME_FLAG} __DOLLAR__{MORE_FLAGS[@]} -cycle -selected-row "__DOLLAR__{SELECTED}" -mesg "__DOLLAR__{MESG}")
              RTR=__DOLLAR__?
              if [ "__DOLLAR__{RTR}" = 10 ]
              then
                  return 0;
              elif [ "__DOLLAR__{RTR}" = 1 ]
              then
                  return 1;
              elif [ "__DOLLAR__{RTR}" = 65 ]
              then
                  return 1;
              fi
              CUR=__DOLLAR__{theme_names[__DOLLAR__{RES}]}
              SELECTED=__DOLLAR__{RES}
          done
      }
      
      ############################################################################################################
      # Actual program execution
      ###########################################################################################################
      ##
      # Find all themes
      ##
      find_themes
      
      ##
      # Do check if there are themes.
      ##
      if [ __DOLLAR__{#themes[@]} = 0 ]
      then
          __DOLLAR__{ROFI} -e "No themes found."
          exit 0
      fi
      
      ##
      # Create copy of config to play with in preview
      ##
      create_config_copy
      
      ##
      # Show the themes to user.
      ##
      if select_theme && [ -n "__DOLLAR__{SELECTED}" ]
      then
          # Apply the selected theme
          add_theme_to_config "__DOLLAR__{theme_names[__DOLLAR__{SELECTED}]}"
      
          selection="__DOLLAR__{theme_names[__DOLLAR__{SELECTED}]}"
          notify_change
      
          # Send notification with the selected theme name
      #    if [ -n "__DOLLAR__NOTIFY_SEND" ]; then
      #        notify-send -u low -i "__DOLLAR__iDIR/ja.png"  "Rofi Theme applied:" "__DOLLAR__selection"
      #    fi
      fi
      
      ##
      # Remove temp. config.
      ##
      rm -- "__DOLLAR__{TMP_CONFIG_FILE}"
    '';
  };
}
