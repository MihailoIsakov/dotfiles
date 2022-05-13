# moving around
alias cd='cd -P'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'
alias ..7='cd ../../../../../../..'

# clear screen
alias cls='printf "\033c"'
alias cl='printf "\033c"'

# ls stuff
alias ls='ls --group-directories-first --color'
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias sl='ls'
alias lt='ll -t'
alias ld='ls -la | grep "^d" && ls -la | grep "^-" && ls -la | grep "^l"'
alias ltr='ll -tr'

# Clone terminal
alias cl='clone_term.sh'

# nemo fucks up i3 with its desktop
alias nemo='nemo --no-desktop'

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
alias activate='source venv/bin/activate'

#experimental
alias ports='netstat -tulanp'

