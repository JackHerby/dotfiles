#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$HOME/.local/bin:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# (ble.sh): Add this lines at the top of .bashrc:
source -- /usr/share/blesh/ble.sh --attach=none

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='nvim'
fi

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Utils
alias c="clear"
alias ccf='cd && clear && fastfetch'
alias cdghostty='cd $HOME/.config/ghostty'
alias cdhypr='cd $HOME/.config/hypr'
alias cdkinpal='cd $HOME/Projects/playpal'
alias cdkitty='cd $HOME/.config/kitty'
alias cdnvim='cd $HOME/.config/nvim'
alias cdoc='cd $HOME/.config/opencode'
alias cf='clear && fastfetch'
alias dfs='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias dfsno='dfs config status.showUntrackedFiles no'
alias dfsnorm='dfs config status.showUntrackedFiles normal'
alias nf='neovide --fork'
alias or='omz reload'
alias s='kitten ssh'
alias sb='source ~/.bashrc'
alias tcheck='sudo timeshift --check'
alias uds='upower -i /org/freedesktop/UPower/devices/battery_ps_controller_battery_14o3ao9ao8foc1o64'
alias vb='$EDITOR $HOME/.bashrc'
alias kgn='kitty +runpy "from kitty.config import *; print(commented_out_default_config())" > ~/.config/kitty/kittty.conf.new'

# Docker
alias dcup='docker compose up'
alias dcupbuild='docker compose up --build'
alias dcdown='docker compose down'
alias dcbuild='docker compose build'
alias dclogs='docker compose logs'
alias dcrestart='docker compose restart'

# Git
gbprune() {
	git fetch -p
	git branch -vv | awk '/: gone]/{print $1}' | xargs -r git branch -D
}

# Misc
function y() {
	local tmp cwd; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
	command rm -f -- "$tmp"
}

# Bun completions
[ -s "/home/jackherby/.bun/_bun" ] && source "/home/jackherby/.bun/_bun"

# fzf
export FZF_DEFAULT_OPTS="--bind 'enter:become($EDITOR {})' \
--preview 'bat --style=numbers --color=always {}' \
--preview-border=sharp \
--preview-window=up"

# (ble.sh): Add this line at the end of .bashrc:
[[ ! ${BLE_VERSION-} ]] || ble-attach
