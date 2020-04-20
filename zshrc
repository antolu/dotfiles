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

# Customize to your needs...

alias pac='sudo pacman -Sy'

mkc () {
	mkdir -p "$1"
	cd "$1"
}

brightness() {
	echo ${$(( $1/100.*120000 ))%.*}  >! /sys/class/backlight/intel_backlight/brightness
}

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

alias windows='sudo nextboot Microsoft && sudo reboot'

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
