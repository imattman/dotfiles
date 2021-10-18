# mattman  .dotfiles/zsh/zshenv.sh

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_LOCAL_HOME="${XDG_LOCAL_HOME:-$HOME/.local}"
export XDG_LOCAL_BIN="${XDG_LOCAL_BIN:-$XDG_LOCAL_HOME/bin}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$XDG_LOCAL_HOME/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$XDG_LOCAL_HOME/state}"


# init zprezto:zshenv
source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshenv"


