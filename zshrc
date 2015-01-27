# ==============================================================================
#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|
# ------------------------------------------------------------------------------
# AA Generate by http://patorjk.com/software/taag / Font : Standard
# ------------------------------------------------------------------------------
#  NOTE
# ------------------------------------------------------------------------------
#  chsh -s /bin/zsh
# ------------------------------------------------------------------------------
#  ローカル設定は $HOME/.zshrc.local 内に追記してください
# ==============================================================================
# LANG
export LANG=ja_JP.UTF-8

# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -alh --color'

if [ -e /usr/local/bin/vim ]; then
  alias vi='/usr/local/bin/vim'
  alias vim='/usr/local/bin/vim'
elif [ -e /usr/bin/vim ]; then
  alias vi='/usr/bin/vim'
  alias vim='/usr/bin/vim'
fi

export EDITOR=vim

# OS 別の設定
case ${OSTYPE} in
darwin*)
#Mac用の設定
export CLICOLOR=1
alias ls='ls -G -F'
;;
linux*)
#Linux用の設定
;;
esac

# ==============================================================================
# vim: set ft=zsh fdm=marker ff=unix fileencoding=utf-8 expandtab ts=2 sw=2 :
# ==============================================================================
