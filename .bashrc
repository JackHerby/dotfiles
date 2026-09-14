#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
alias cdghostty='cd ~/.config/ghostty'
alias cdhypr='cd ~/.config/hypr'
alias cdkinpal='cd ~/Projects/playpal'
alias cdkitty='cd ~/.config/kitty'
alias cdnvim='cd ~/.config/nvim'
alias cdoc='cd ~/.config/opencode'
alias cdomz='cd /usr/share/oh-my-zsh/'
alias cn='clear && fastfetch'
alias dotf='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias dotfnorm='dotf config status.showUntrackedFiles normal'
alias dotfno='dotf config status.showUntrackedFiles no'
alias nf='neovide --fork'
alias nomza='nvim ~/.oh-my-zsh/custom/aliases.zsh'
alias nzh='nvim ~/.zsh_history'
alias ocp='opencode --port'
alias or='omz reload'
alias s="kitten ssh"
alias skp="kitten ssh ubuntu@146.59.33.178"
alias tcheck='sudo timeshift --check'
alias uds='upower -i /org/freedesktop/UPower/devices/battery_ps_controller_battery_14o3ao9ao8foc1o64'

myfuncs() { grep -E "^[a-zA-Z_][a-zA-Z0-9_]*\(\)" ~/.oh-my-zsh/custom/aliases.zsh | sed 's/().*//'; }

hg() {
    if [ -z "$1" ]; then
        echo "Usage: hg <command>"
        return 1
    fi
    history | grep "$1" | less
}

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
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Bun completions
[ -s "/home/jackherby/.bun/_bun" ] && source "/home/jackherby/.bun/_bun"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fzf
export FZF_DEFAULT_OPTS="--layout=reverse --preview 'bat --style=numbers --color=always {}'"

# fnm
eval "$(fnm env --use-on-cd --shell bash)"

# (ble.sh): Add this line at the end of .bashrc:
[[ ! ${BLE_VERSION-} ]] || ble-attach
