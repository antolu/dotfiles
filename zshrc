#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# ============================================================================
# 
# Enviromnent variables
#
# ============================================================================

export EDITOR=/usr/bin/vim

# ============================================================================
# 
# Aliases
#
# ============================================================================

alias gitls='git status'
alias pac='sudo pacman -Sy'
alias please='sudo'
alias svim='sudo vim'
alias wifi="nmcli d wifi"
alias windows='sudo nextboot Microsoft && sudo reboot'

# ============================================================================
# 
# Functions 
#
# ============================================================================

mkc () {
	mkdir -p "$1"
	cd "$1"
}

gitc () {
  git clone "$1" "$2"

  if [[ -z $2 ]]; then
    cd "$2"
  else
    cd "$1"
  fi
}


brightness () {
	echo ${$(( $1/100.*120000 ))%.*}  >! /sys/class/backlight/intel_backlight/brightness
}


wifiscan () {
  wifi list
}

wificonnect () {
  if [[ -z "$2" ]]; then
    wifi connect "$1"
  else
    wifi connect "$1" password "$2"
  fi
}

watchfile() {
while inotifywait -q -e modify "$1" >/dev/null; do
    "$2"
done
}

sedrename() {
  if [ $# -gt 1 ]; then
    sed_pattern=$1
    shift
    for file in $(ls $@); do
      mv -v "$file" "$(sed $sed_pattern <<< $file)"
    done
  else
    echo "usage: $0 sed_pattern files..."
  fi
}

syncdir() {
  if [[ -z `command -v rsync` ]]; then
    echo "rsync is not installed. Exiting."
    return
  fi

  if [[ -z "$1" ]]; then
    DIR="$HOME/code/"
    echo "Directory not supplied. Using default $DIR."
  else
    DIR="$1"
  fi

  if [[ -z "$2" ]]; then 
    RDIR="olympus:code"
  else
    RDIR="$2"
  fi

  if [[ -z "$3" ]]; then  # recursion depth
    N=2
  else
    N="$3"
  fi

  if [[ ! -d "$DIR" ]]; then
    echo "$DIR is not a directory. Exiting."
    return
  fi

  RSYNCFLAGS=" -azP --delete "

  if [[ -f "$DIR/.syncignore" || N -eq "0" ]]; then
    RSYNCFLAGS+=" --exclude-from=$DIR/.syncignore"
    rsync "$RSYNCFLAGS" "$DIR" "$RDIR"
    return
  else
    DEPTH=$(( N - 1 ))
    for dir in $DIR/*/; do
      sleep 1
      folder=${dir#"$DIR"}
      remote="$RDIR/$folder"

      # Add trailing slash
      dir="$dir/"

      # echo "origin: $dir | remote: $remote | N=$DEPTH"
      syncdir $dir $remote $DEPTH
    done
    return
  fi
}


# ============================================================================
# 
# Other
#
# ============================================================================

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/anton/.conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/anton/.conda/etc/profile.d/conda.sh" ]; then
        . "/home/anton/.conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/anton/.conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

