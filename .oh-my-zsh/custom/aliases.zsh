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
alias df='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias dfnorm='df config status.showUntrackedFiles normal'
alias dfno='df config status.showUntrackedFiles no'
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

# bluetoothctl
alias b='bluetoothctl'
alias bd='bluetoothctl devices'

alias bcheadphones='bluetoothctl connect AC:80:0A:CB:5E:47'
alias bcspeaker='bluetoothctl connect 41:42:9A:1A:E1:0F'

alias bdcheadphones='bluetoothctl disconnect AC:80:0A:CB:5E:47'
alias bdcspeaker='bluetoothctl disconnect 41:42:9A:1A:E1:0F'
alias bdccontroller='bluetoothctl disconnect 14:3A:9A:8F:C1:64'

alias highfidelityplayback='pactl set-card-profile bluez_card.AC_80_0A_CB_5E_47 a2dp-sink'
alias headsetheadunit='pactl set-card-profile bluez_card.AC_80_0A_CB_5E_47 headset-head-unit'

bconnect() {
    if [ -z "$1" ]; then
        echo "Usage: bconnect <device_name>"
        return 1
    fi
    bluetoothctl connect "$1"
}

bdisconnect() {
    if [ -z "$1" ]; then
        echo "Usage: bdisconnect <device_name>"
        return 1
    fi
    bluetoothctl disconnect "$1"
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
