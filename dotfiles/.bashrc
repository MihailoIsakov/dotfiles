export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8

export VISUAL=vim
export EDITOR=vim
set -o vi
set editing-mode vi
set keymap vi-command

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3'
source "/home/mihailo/.local/bin/virtualenvwrapper.sh"

# Created by `pipx` on 2022-01-21 17:21:54
export PATH="$PATH:/home/mihailo/.local/bin"

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

####################################################################################################
# Colors and UX                                                                                    # 
####################################################################################################
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# color the cursor for better visibility
echo -ne '\e]12;orange\a'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

####################################################################################################
# Shell setup 
####################################################################################################
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history. See bash(1) for more options
# HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=100000
# append to the history file, don't overwrite it
shopt -s histappend
# After each command, append to the history file and reread it
# PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Jump (https://github.com/gsamokovarov/jump) shell integration
# eval "$(jump shell)"

# ssh agent 
if [ -f ~/.ssh/agent.env ] ; then
    . ~/.ssh/agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        echo "Stale agent file found. Spawning a new agent. "
        eval `ssh-agent | tee ~/.ssh/agent.env`
        ssh-add
    fi
else
    echo "Starting ssh-agent"
    eval `ssh-agent | tee ~/.ssh/agent.env`
    ssh-add
fi


####################################################################################################
# Autocompletion
####################################################################################################
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# don't autocomplete hidden files
bind 'set match-hidden-files off'

# Bash Git setup 
# source ~/bin/git-completion.bash

# Fuzzy search autocompletion and terminal key bindings
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

######################
# Powerline-go shell #
######################
function _update_ps1() {
    #PS1="$(/home/mihailo/bin/powerline-go -error $? -jobs $(jobs -p | wc -l))"
    #PS1=$(/home/mihailo/bin/powerline-go -error $? -cwd-max-depth 10 -modules="time,ssh,venv,cwd,git,newline" -theme "gruvbox" )
    PS1=$(/home/mihailo/bin/powerline-go -error $? -cwd-max-depth 1 -modules="time,ssh,venv,cwd,git,newline" -theme "gruvbox" )

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want.

    #set "?"
}

if [ "$TERM" != "linux" ] && [ -f "/home/mihailo/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi


