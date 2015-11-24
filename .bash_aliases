# moving around
alias cd='cd -P'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'
alias ..7='cd ../../../../../../..'
alias cls='printf "\033c"'
alias cl='printf "\033c"'

# ls stuff
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias sl='ls'
alias lt='ll -t'
alias ld='ls -la | grep "^d" && ls -la | grep "^-" && ls -la | grep "^l"'
alias ltr='ll -tr'

# hide python pyc files
alias lp='ls --hide="*.pyc"'

alias gp=' | grep -i'

# wraping bash
alias nowrap="printf '\033[?7l'"
alias wrap="printf '\033[?7h'"

# nemo fucks up i3 with its desktop
alias nemo='nemo --no-desktop'
alias wifi='nm-applet &'

# tools
alias cat='pygmentize -g'
alias chrome='google-chrome'
alias open='gnome-open'
alias xclip='xclip -sel clip'
    #calendar stuff
    alias cal='gcalcli'
    alias calm='gcalcli calm'
    alias calw='gcalcli calw'

# git stuff
alias log="git log --graph --branches --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gs='git status'
alias diff='git diff'
alias commit='git commit'
alias add='git add'
alias gs='git status'
alias checkout='git checkout'
alias pull='git pull'
alias gtc='git show --name-only'

# language specific tools
alias ipy='ipython'
alias activate='source venv/bin/activate'
#alias lixc='elixirc'
#alias lix='elixir'

#experimental
alias ports='netstat -tulanp'
