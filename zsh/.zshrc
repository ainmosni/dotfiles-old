# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export ZSH_CUSTOM=$HOME/.zsh-custom
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bullet-train"
BULLETTRAIN_CONTEXT_SHOW="true"
BULLETTRAIN_CONTEXT_DEFAULT_USER="daniel"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(ssh-agent git django extract python svn vim fabric extract pip booking zsh-syntax-highlighting archlinux golang pip gpg-agent colored-man-pages thefuck)

# Are we on arch?
if [[ -e /etc/arch-release ]]; then
    plugins=($plugins archlinux)
fi

# Is this a debian derivative?
if [[ -e /etc/debian_version ]]; then
    plugins=($plugins debian command-not-found)
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
    plugins=($plugins brew)
fi


export LANG=en_DK.UTF-8
export LC_ALL=en_DK.UTF-8
# I want agent forwarding on. 
zstyle :omz:plugins:ssh-agent agent-forwarding on

PRODUCTION_RE='^nut'
source $ZSH/oh-my-zsh.sh


# Customize to your needs...
PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin/vendor_perl/"
PATH="$PATH:$HOME/.bin:$HOME/.sbin"

# Turn on 256 color support...
if [ "x$TERM" = "xterm" ]
then
    export TERM="xterm-256color"
fi

# Mutt colours
set COLORFGBG="lightgray;default"
export COLORFGBG

# dircolors
eval "$(dircolors ~/.dircolors)"

# set extended globbing
setopt extended_glob

export EDITOR=vim
# tmux hack
if [ ! -z "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent_sock" ] ; then
    unlink "$HOME/.ssh/agent_sock" 2>/dev/null
    ln -s "$SSH_AUTH_SOCK" "$HOME/.ssh/agent_sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
fi

if [ -f ~/.zshrc.local ]
then
    . ~/.zshrc.local
fi

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	BULLETTRAIN_IS_SSH_CLIENT=true
fi

export WORKON_HOME=~/.venv
source /usr/bin/virtualenvwrapper.sh

fortune -a
unset GREP_OPTIONS
