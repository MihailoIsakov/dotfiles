# moving around
alias cd='cd -P'
alias ..='cd ..'
alias ...='cd ../..'
alias ..2='cd ../..'
alias ....='cd ../../..'
alias ..3='cd ../../..'

# clear screen
alias cls='printf "\033c"'
alias cl='printf "\033c"'

# ls stuff
alias sl='ls'
alias ls='ls --group-directories-first --color'
alias ll='ls -latrh'
alias ld='ls -la | grep "^d" && ls -la | grep "^-" && ls -la | grep "^l"'

# Clone terminal
alias cl='clone_term.sh'

alias chrome='google-chrome'
alias open='xdg-open'
alias xclip='xclip -sel clip'

# git stuff
alias log="git log --graph --branches --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --all --decorate"
alias gs='git status'
alias diff='git diff -w'
alias diffw='git diff --word-diff'
alias diffwd='git diff --word-diff-regex=.'
alias diffc='git diff --color-words --word-diff-regex=.'
alias diffca='git diff --color-words --word-diff --no-prefix -U1000'
alias gdt='git difftool'
alias commit='git commit'
alias add='git add'
alias gs='git status'
alias co='git checkout'
alias pull='git pull'
alias gtc='git show --name-only'
alias push='git push'

# language specific tools
alias ipy='ipython'
# Activate, assuming that ~/bin/source_venv exists
alias activate='source source_venv'

# enable aliases in non-interactive shells like vim
shopt -s expand_aliases

# kitty clipboard
alias cb='kitty +kitten clipboard'

# kitty ssh
alias s="kitty +kitten ssh"
