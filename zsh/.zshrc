# Load antigen
source ~/.antigen/antigen.zsh

# Load the oh-my-zsh library
antigen use oh-my-zsh

antigen bundle git
antigen bundle extract
antigen bundle python
antigen bundle golang
antigen bundle gpg-agent
antigen bundle thefuck
antigen bundle virtualenv
antigen bundle virtualenvwrapper
antigen bundle colorize
antigen bundle docker
antigen bundle postgres

antigen bundle djui/alias-tips
antigen bundle jocelynmallon/zshmarks
antigen bundle unixorn/git-extra-commands
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle marzocchi/zsh-notify
antigen bundle psprint/zsh-cmd-architect
antigen bundle supercrabtree/k
antigen bundle mollifier/cd-gitroot

if [[ -e /etc/arch-release ]]; then
    antigen bundle archlinux
    antigen bundle systemd
fi

if [[ -e /etc/debian_version ]]; then
    antigen bundle debian
    antigen bundle command-not-found
fi

# Add local settings before the theme and apply so that we can configure local
# antigen settings.
if [ -e ~/.zshrc.local ]; then
    . ~/.zshrc.local
fi

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir root_indicator)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs virtualenv time)

antigen theme bhilburn/powerlevel9k powerlevel9k

# Apply all the antigen stuff
antigen apply

# en_DK for the only English locale with ISO datetime formats
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Turn on 256 color support...
if [ "x$TERM" = "xterm" ]
then
    export TERM="xterm-256color"
fi

# dircolors
eval "$(dircolors ~/.dircolors)"


# Some ssh agent hacks
if [ -S "/run/user/$UID/gnupg/S.gpg-agent.ssh" ] ; then
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

# Enable agent in t-mux
if [ ! -z "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent_sock" ] ; then
    unlink "$HOME/.ssh/agent_sock" 2>/dev/null
    ln -s "$SSH_AUTH_SOCK" "$HOME/.ssh/agent_sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
fi

# Set bullet-train ssh mode on if we're in SSH
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	BULLETTRAIN_IS_SSH_CLIENT=true
fi

# Some final environment variables
export GOPATH=~/go
export PATH="$PATH:$HOME/.bin:$HOME/.sbin:${GOPATH}/bin:/usr/local/bin"
export EDITOR=vim


# Fortune for good measure
fortune -a
