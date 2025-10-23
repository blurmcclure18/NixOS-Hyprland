# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

alias ..='cd ..'
alias b='btop'
alias c='clear'
alias chypr='cd ~/.config/hypr'
alias n='nvim'
alias nzsh='nvim ~/.zshrc'
alias nhypr='nvim ~/.config/hypr/hyprland.conf'
alias nniri='nvim ~/.config/niri/config.kdl'
alias nnix='sudo nvim /etc/nixos/configuration.nix'
alias rebuild-switch='sudo nixos-rebuild switch'
alias rebuild-test='sudo nixos-rebuild test'
alias nsearch='custom_nix_search'
alias :vpn="sudo openconnect cva.uscourts.gov --user=alecmcclure --useragent='AnyConnect'"


custom_nix_search() {
  local query="$*"
  nix-search -c "25.05" "$query"
}

# Function to display colored text from a hex code
hex_color() {
  local hex=$1
  local text=${2:-"  "}
  local r=$(printf %d "0x${hex:0:2}")
  local g=$(printf %d "0x${hex:2:2}")
  local b=$(printf %d "0x${hex:4:2}")
  printf '\e[48;2;%d;%d;%dm%s\e[0m\n' $r $g $b "$text"
}


eval "$(fzf --zsh)"
