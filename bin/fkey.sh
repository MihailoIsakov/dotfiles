F_key=$1 
command="${@:2}"
tmux new -s $F_key -d
tmux send-keys -t $F_key "run(){  pop; ${command} ; beep; } " C-m 
tmux attach -t $F_key
