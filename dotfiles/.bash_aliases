# moving around
# alias cd='cd -P'

cd() {
    builtin cd -P "$@" || return
    _update_terminal_bg_for_git
}

_update_terminal_bg_for_git() {
    local branch
    if branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
        local hash=$(echo -n "$branch" | cksum | cut -d' ' -f1)
        local r=$(( (hash         % 50) + 30 ))
        local g=$(( (hash / 256   % 50) + 30 ))
        local b=$(( (hash / 65536 % 50) + 30 ))
        printf '\033]11;#%02x%02x%02x\007' "$r" "$g" "$b"
    else
        # Not a git repo or detached HEAD - reset to default (black)
        printf '\033]11;#2e2e2e\007'
        # printf '\033]11;#000000\007'
    fi
}

# Run on shell startup to set initial color
_update_terminal_bg_for_git

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
alias ls='ls -t --group-directories-first --color'
alias la='ls -a'
alias ll='ls -latrh'
# alias ld='ls -la | grep "^d" && ls -la | grep "^-" && ls -la | grep "^l"'
alias ld='ls -la | grep "^d"'

# Clone terminal
alias cl='clone_term.sh'

alias chrome='google-chrome'
alias open='xdg-open'
alias xclip='xclip -sel clip'

# git stuff
# alias log="git log --graph --branches --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --all --decorate"
alias log="git log --graph --branches --pretty=format:'%C(yellow)%h%Creset %C(bold blue)<%an>%Creset %Cgreen(%cr)%Creset -%C(auto)%d%Creset %s' --abbrev-commit --date=relative --all --decorate"
alias logg="git log --graph --branches --simplify-by-decoration --pretty=format:'%C(yellow)%h%Creset %C(bold blue)<%an>%Creset %Cgreen(%cr)%Creset -%C(auto)%d%Creset %s' --abbrev-commit --date=relative --all --decorate"
# alias logg="git log --graph --oneline --all --simplify-by-decoration --date=relative"
alias gs='git status'
alias gb="git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias diff='git diff -w'
alias diffw='git diff --word-diff'
alias diffwd='git diff --word-diff-regex=.'
alias diffc='git diff --color-words --word-diff-regex=.'
alias diffca='git diff --color-words --word-diff --no-prefix -U1000'
alias cached='git diff --cached'
alias gdt='git difftool'
alias commit='git commit'
alias add='git add'
alias gs='git status'
alias co='git checkout'
alias pull='git pull'
alias gtc='git show --name-only'
alias push='git push'
alias amend='git commit --amend'
alias gprunesquashmerged='git checkout -q main && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base main $branch) && [[ $(git cherry main $(git commit-tree $(git rev-parse "$branch^{tree}") -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'

# rg follow symlinks
alias rg='rg -L'

# language specific tools
alias ipy='ipython'
alias pc='uv run pre-commit'
# Activate, assuming that ~/bin/source_venv exists
alias activate='source source_venv'

# enable aliases in non-interactive shells like vim
shopt -s expand_aliases

# clear vim since kitty sometimes mangles the terminal outputs
# alias vim='clear; nvim'
alias vim='nvim'

# kitty clipboard
alias cb='kitty +kitten clipboard'

# kitty ssh
alias kssh="kitty +kitten ssh"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# gtkwave
alias gtkwave="gtkwave --rcvar 'fontname_signals Firacode 16' --rcvar 'fontname_waves Firacode 16'"

# zathura
alias zs="swallow zathura"  

# github CLI
feature() {
        gh issue create --title "$*" --body "" --label "enhancement"
}

bug() {
        gh issue create --title "$*" --body "" --label "bug"
}

# I keep making this mistake, so might as well:
alias :q=exit
