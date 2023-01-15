# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
export PATH=$PATH:/opt/cuda/bin:/usr/local/texlive/2022/bin/x86_64-linux

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
alias cernproxy='ssh -N -D 9090 lxplus'
alias cernvmproxy='ssh -L 5901:localhost:5901 cernvm'
alias ibrew="arch -x86_64 /usr/local/bin/brew"

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

mkv2mp4() {
    ffmpeg -i "$1" -map 0 -codec copy -c:s mov_text -tag:v hvc1 "$2"
}

clip() {
    xclip -selection C "$1"
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
    return 1
  fi

  if [[ -z "$1" ]]; then
    DIR="$HOME/code"
    echo "Directory not supplied. Using default $DIR."
  else
    DIR="$1"
  fi

  if [[ -z "$2" ]]; then
    if [[ ! -z "$1" ]]; then
      echo "\033[-;31m => You have to supply a destination if using a custom origin."
      return 2
     fi
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

  RSYNCFLAGS=" -azuzP --delete "

  if [[ -f "$DIR/.syncignore" || N -eq "0" ]]; then
    RSYNCFLAGS+=" --exclude-from=$DIR/.syncignore "
    eval "rsync $RSYNCFLAGS $DIR/ $RDIR"
    eval "rsync $RSYNCFLAGS $RDIR/ $DIR"
    echo -e "\033[0;34m => Sync finished."
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

  echo -e "\033[0;32m => Sync finished."
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
