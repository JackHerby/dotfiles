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
alias ccn='cd && clear && fastfetch'
alias cdghostty='cd $HOME/.config/ghostty'
alias cdhypr='cd $HOME/.config/hypr'
alias cdkinpal='cd $HOME/Projects/playpal'
alias cdkitty='cd $HOME/.config/kitty'
alias cdnvim='cd $HOME/.config/nvim'
alias cdoc='cd $HOME/.config/opencode'
alias cn='clear && fastfetch'
alias dfs='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias dfsno='dfs config status.showUntrackedFiles no'
alias dfsnorm='dfs config status.showUntrackedFiles normal'
alias hd='history -d -2 && history -w'
alias nf='neovide --fork'
alias ocp='opencode --port'
alias or='omz reload'
alias s='kitten ssh'
alias tcheck='sudo timeshift --check'
alias uds='upower -i /org/freedesktop/UPower/devices/battery_ps_controller_battery_14o3ao9ao8foc1o64'
alias vb='$EDITOR $HOME/.bashrc'

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
export FZF_DEFAULT_OPTS="--layout=reverse --preview 'bat --style=numbers --color=always {}'"

# (ble.sh): Add this line at the end of .bashrc:
[[ ! ${BLE_VERSION-} ]] || ble-attach
