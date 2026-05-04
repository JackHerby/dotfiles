# Utils
alias ccn='cd && clear && neofetch'
alias cdghostty='cd ~/.config/ghostty'
alias cdkitty='cd ~/.config/kitty'
alias cdnvim='cd ~/.config/nvim'
alias cdoc='cd ~/.config/opencode'
alias cdomz='cd /usr/share/oh-my-zsh/'
alias cn='clear && neofetch'
alias df='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias dfnorm='df config status.showUntrackedFiles normal'
alias dfno='df config status.showUntrackedFiles no'
alias nf='neovide --fork'
alias nomza='nvim ~/.oh-my-zsh/custom/aliases.zsh'
alias nzh='nvim ~/.zsh_history'
alias ocp='opencode --port'
alias or='omz reload'
alias tcheck='sudo timeshift --check'

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

# Recovered work aliases and helpers from live shell state.
DIVIDER_MAIN='================================================================================'
DIVIDER_SUB='--------------------------------------------------------------------------------'
CHECK_RUNPY='if [ ! -f "run.py" ]; then echo "Error: run.py not found in current directory" >&2; return 1; fi'

alias cdfrc='cd ~/Projects/fr/cms/'
alias cdfrct='cd ~/Projects/fr/cms/tools/'
alias cdfre='cd ~/Projects/fr/end-to-end/'
alias cdfrw='cd ~/Projects/fr/bonprix-www/'
alias cdfrwb='cd ~/Projects/fr/bonprix-www/base/'
alias cdfrws='cd ~/Projects/fr/bonprix-www/ssr/'
alias cdfrwt='cd ~/Projects/fr/bonprix-www/tools/'
alias cdplc='cd ~/Projects/pl/bonprix-cms/'
alias cdplct='cd ~/Projects/pl/bonprix-cms/tools/'
alias cdple='cd ~/Projects/pl/end-to-end/'
alias cdplw='cd ~/Projects/pl/bonprix-www/'
alias cdplwb='cd ~/Projects/pl/bonprix-www/base/'
alias cdplws='cd ~/Projects/pl/bonprix-www/ssr/'
alias cdplwt='cd ~/Projects/pl/bonprix-www/tools/'
alias dbefl='service_down dev/befl'
alias dbewa='service_down dev/bewa'
alias dcms='service_down dev/cms'
alias dcz='service_down dev/cz'
alias dfr='service_down dev/fr'
alias dhu='service_down dev/hu'
alias dnl='service_down dev/nl'
alias dpl='service_down dev/pl'
alias dpsa='docker ps -a --format "{{.Names}}"'
alias dpsbefl='docker ps -f "name=bonprix-dev-befl-nginx-ssr"'
alias dpsbewa='docker ps -f "name=bonprix-dev-bewa-nginx-ssr"'
alias dpscz='docker ps -f "name=bonprix-dev-cz-nginx-ssr"'
alias dpsfr='docker ps -f "name=bonprix-dev-fr-nginx-ssr"'
alias dpshu='docker ps -f "name=bonprix-dev-hu-nginx-ssr"'
alias dpsnl='docker ps -f "name=bonprix-dev-nl-nginx-ssr"'
alias dpspl='docker ps -f "name=bonprix-dev-pl-nginx-ssr"'
alias dpsro='docker ps -f "name=bonprix-dev-ro-nginx-ssr"'
alias dpssk='docker ps -f "name=bonprix-dev-sk-nginx-ssr"'
alias dro='service_down dev/ro'
alias dsk='service_down dev/sk'
alias dstackbefl='dbefl && dtc'
alias dstackbeflp='dbeflp && dtc'
alias dstackbewa='dbewa && dtc'
alias dstackbewap='dbewap && dtc'
alias dstackcms='dcms && dtc'
alias dstackcz='dcz && dtc'
alias dstackczp='dczp && dtc'
alias dstackfr='dfr && dtc'
alias dstackfrp='dfrp && dtc'
alias dstackhu='dhu && dtc'
alias dstackhup='dhup && dtc'
alias dstacknl='dnl && dtc'
alias dstacknlp='dnlp && dtc'
alias dstackpl='dpl && dtc'
alias dstackplp='dplp && dtc'
alias dstackro='dro && dtc'
alias dstackrop='drop && dtc'
alias dstacksk='dsk && dtc'
alias dstackskp='dskp && dtc'
alias dstackua='dua && dtc'
alias dstackuap='duap && dtc'
alias dtc='service_down tools/connection'
alias dua='service_down dev/ua'
alias lbefl='service_logs dev/befl'
alias lbeflp='service_logs dev/befl/local'
alias lbewa='service_logs dev/bewa'
alias lbewap='service_logs dev/bewa/local'
alias lcms='service_logs dev/cms'
alias lcz='service_logs dev/cz'
alias lczp='service_logs dev/cz/local'
alias lfr='service_logs dev/fr'
alias lfrp='service_logs dev/fr/local'
alias lhu='service_logs dev/hu'
alias lhup='service_logs dev/hu/local'
alias lnl='service_logs dev/nl'
alias lnlp='service_logs dev/nl/local'
alias lpl='service_logs dev/pl'
alias lplp='service_logs dev/pl/local'
alias lro='service_logs dev/ro'
alias lrop='service_logs dev/ro/local'
alias lsk='service_logs dev/sk'
alias lskp='service_logs dev/sk/local'
alias ltc='service_logs tools/connection'
alias lua='service_logs dev/ua'
alias luap='service_logs dev/ua/local'
alias mongotunnel='~/db_tunnels.sh'
alias rbefl='service_restart dev/befl'
alias rbeflp='service_restart dev/befl/local'
alias rbewa='service_restart dev/bewa'
alias rbewap='service_restart dev/bewa/local'
alias rcms='service_restart dev/cms'
alias rcz='service_restart dev/cz'
alias rczp='service_restart dev/cz/local'
alias rfr='service_restart dev/fr'
alias rfrp='service_restart dev/fr/local'
alias rhu='service_restart dev/hu'
alias rhup='service_restart dev/hu/local'
alias rnl='service_restart dev/nl'
alias rnlp='service_restart dev/nl/local'
alias rpl='service_restart dev/pl'
alias rplp='service_restart dev/pl/local'
alias rro='service_restart dev/ro'
alias rrop='service_restart dev/ro/local'
alias rsk='service_restart dev/sk'
alias rskp='service_restart dev/sk/local'
alias rtc='service_restart tools/connection'
alias rua='service_restart dev/ua'
alias ruap='service_restart dev/ua/local'
alias ubefl='service_up dev/befl'
alias ubeflp='service_up dev/befl/local'
alias ubewa='service_up dev/bewa'
alias ubewap='service_up dev/bewa/local'
alias ucms='service_up dev/cms'
alias ucz='service_up dev/cz'
alias uczp='service_up dev/cz/local'
alias ufr='service_up dev/fr'
alias ufrp='service_up dev/fr/local'
alias uhu='service_up dev/hu'
alias uhup='service_up dev/hu/local'
alias unl='service_up dev/nl'
alias unlp='service_up dev/nl/local'
alias upl='service_up dev/pl'
alias uplp='service_up dev/pl/local'
alias uro='service_up dev/ro'
alias urop='service_up dev/ro/local'
alias usk='service_up dev/sk'
alias uskp='service_up dev/sk/local'
alias utc='service_up tools/connection'
alias uua='service_up dev/ua'
alias uuap='service_up dev/ua/local'
alias zdt='zsh ~/db_tunnels.sh'

print_section() {
    echo "${DIVIDER_MAIN}"
    echo "$1"
    echo "${DIVIDER_MAIN}"
    echo
}

gsbprune() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository" >&2
        return 1
    fi
    print_section "Cleaning up main repository"
    gbprune
    echo
    print_section "Cleaning up submodules"
    git submodule foreach --quiet '
  echo "'"$DIVIDER_SUB"'"
  echo "Processing submodule: $name"
  echo "'"$DIVIDER_SUB"'"

  # Fetch and prune
  git fetch --prune >/dev/null 2>&1

  # Find branches without upstream
  branches_to_delete=$(git branch -vv | grep ": gone]" | awk "{print \$1}")

  if [ -z "$branches_to_delete" ]; then
    echo "No local branches to delete"
  else
    echo "Found branches without upstream:"
    echo "$branches_to_delete" | while read branch; do
      echo "  - $branch"
    done

    echo "$branches_to_delete" | while read branch; do
      if git branch -d "$branch" 2>/dev/null; then
        echo "  ✓ Deleted $branch"
      elif git branch -D "$branch" 2>/dev/null; then
        echo "  ✓ Force deleted $branch"
      else
        echo "  ✗ Failed to delete $branch" >&2
      fi
    done
  fi
  echo
  '
    echo "Submodule cleanup complete!"
}

gscheckout() {
    if [ -z "$1" ]; then
        echo "Usage: gscheckout <branch|commit>" >&2
        return 1
    fi
    local target_branch="$1"
    local exit_code=0
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository" >&2
        return 1
    fi
    print_section "Checking out '$target_branch' in main repository..."
    if git checkout "${target_branch}"; then
        echo
    else
        echo "Error: Failed to checkout '$target_branch' in main repository" >&2
        echo "Continuing with submodules..." >&2
        exit_code=1
        echo
    fi
    print_section "Checking out '$target_branch' in submodules..."
    git submodule foreach --quiet "
  echo \"$DIVIDER_SUB\"
  echo \"Checking out $target_branch in submodule: \$name\"
  echo \"$DIVIDER_SUB\"
  git fetch origin >/dev/null 2>&1
  if git show-ref --verify --quiet refs/heads/$target_branch || git show-ref --verify --quiet refs/remotes/origin/$target_branch; then
    git checkout $target_branch 2>/dev/null || git checkout -b $target_branch origin/$target_branch 2>/dev/null || echo \"Error: Failed to checkout $target_branch in \$name\" >&2
    echo
  else
    echo \"Warning: Branch/commit $target_branch does not exist in \$name\" >&2
    echo
  fi
  "
    return ${exit_code}
}

gsdel() {
    if [ -z "$1" ]; then
        echo "Usage: gsdel <branch>" >&2
        return 1
    fi
    local target_branch="$1"
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository" >&2
        return 1
    fi
    print_section "Deleting branch '$target_branch' in main repository..."
    if git show-ref --verify --quiet refs/heads/"${target_branch}"; then
        if git branch -d "${target_branch}" 2> /dev/null || git branch -D "${target_branch}"; then
            echo "Successfully deleted '$target_branch' in main repository"
        else
            echo "Warning: Could not delete '$target_branch' in main repository" >&2
        fi
    else
        echo "Info: Branch '$target_branch' does not exist in main repository"
    fi
    echo
    print_section "Deleting branch '$target_branch' in submodules..."
    git submodule foreach --quiet "
  echo \"$DIVIDER_SUB\"
  echo \"Processing submodule: \$name\"
  echo \"$DIVIDER_SUB\"
  if git show-ref --verify --quiet refs/heads/$target_branch; then
    if git branch -d $target_branch 2>/dev/null || git branch -D $target_branch 2>/dev/null; then
      echo \"Successfully deleted '$target_branch' in \$name\"
    else
      echo \"Warning: Could not delete '$target_branch' in \$name\" >&2
    fi
  else
    echo \"Info: Branch '$target_branch' does not exist in \$name\"
  fi
  echo
  "
}

gspull() {
    print_section "Pulling main repository..."
    git pull
    echo
    print_section "Pulling submodules..."
    git submodule foreach "git pull && echo '$DIVIDER_SUB'"
}

gsrestore() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository" >&2
        return 1
    fi
    print_section "Restoring changes in main repository..."
    git restore . && git clean -fd
    echo
    print_section "Restoring changes in submodules..."
    git submodule foreach --quiet '
  echo "'"$DIVIDER_SUB"'"
  echo "Restoring in submodule: $name"
  echo "'"$DIVIDER_SUB"'"
  git restore . && git clean -fd
  echo
  '
}

gsrestorestaged() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository" >&2
        return 1
    fi
    print_section "Restoring changes in main repository..."
    git restore --staged . && git clean -fd
    echo
    print_section "Restoring changes in submodules..."
    git submodule foreach --quiet '
  echo "'"$DIVIDER_SUB"'"
  echo "Restoring in submodule: $name"
  echo "'"$DIVIDER_SUB"'"
  git restore --staged . && git clean -fd
  echo
  '
}

gsstatus() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository" >&2
        return 1
    fi
    print_section "Status of main repository"
    git status
    echo
    print_section "Status of submodules"
    git submodule foreach --quiet '
  echo "'"$DIVIDER_SUB"'"
  echo "Submodule: $name"
  echo "'"$DIVIDER_SUB"'"
  git status
  echo
  '
}

gstprune() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository" >&2
        return 1
    fi
    print_section "Pruning tags in main repository"
    git fetch --prune origin "+refs/tags/*:refs/tags/*"
    echo
    print_section "Pruning tags in submodules"
    git submodule foreach --quiet '
  echo "'"$DIVIDER_SUB"'"
  echo "Processing submodule: $name"
  echo "'"$DIVIDER_SUB"'"
  git fetch --prune origin "+refs/tags/*:refs/tags/*"
  echo
  '
    echo "Submodule tag cleanup complete!"
}

service_down() {
    eval "${CHECK_RUNPY}"
    python run.py "$1" down
}

service_logs() {
    eval "${CHECK_RUNPY}"
    if [ -n "$2" ]; then
        python run.py "$1" logs "$2"
    else
        python run.py "$1" logs
    fi
}

service_restart() {
    eval "${CHECK_RUNPY}"
    if [ -n "$2" ]; then
        python run.py "$1" restart "$2"
    else
        python run.py "$1" restart
    fi
}

service_up() {
    eval "${CHECK_RUNPY}"
    python run.py "$1" up
}
