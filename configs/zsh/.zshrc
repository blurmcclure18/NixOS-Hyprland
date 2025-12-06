# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

alias ..='cd ..'
alias b='btop'
alias c='clear'
alias chypr='cd ~/.dotfiles/configs/hyprland'
alias di='dua i /'
alias n='nvim'
alias nconf='yazi ~/.dotfiles/configs'
alias nesp='nvim ~/.config/espanso/match/base.yml'
alias nflake='nvim ~/.dotfiles/flake.nix'
alias nhome='nvim ~/.dotfiles/home.nix'
alias nhost='yazi ~/.dotfiles/hosts'
alias nhypr='nvim ~/.dotfiles/configs/hyprland/hyprland.conf'
alias nnix='nvim ~/.dotfiles/hosts/System_Configs/system-configuration.nix'
alias nzsh='nvim ~/.dotfiles/configs/zsh/.zshrc'
alias rebuild-flake='rebuild_flake'
alias rebuild-home='home-manager switch --flake ~/.dotfiles'
alias nsearch='custom_nix_search'
alias :vpn="sudo openconnect cva.uscourts.gov --user=alecmcclure --useragent='AnyConnect'"

custom_nix_search() {
  local query="$*"
  nix-search -c "25.05" "$query"
}

rebuild_flake() {
  if [ -z "$1" ]; then
    echo "Usage: rebuild-flake <hostname>"
    return 1
  fi

  sudo nixos-rebuild switch --flake ~/.dotfiles#$1
}

_rebuild_flake_complete() {
  local -a hosts
  hosts=("home-nixos" "laptop-nixos" "optiplex-nixos") # add more if needed
  _describe 'hosts' hosts
}
compdef _rebuild_flake_complete rebuild-flake
eval "$(fzf --zsh)"
