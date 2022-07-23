pids=$(xdotool search --class Scratch)

if [ -z "$pids" ]; then
    echo "No scratchpad found... Creating one..."
    alacritty --class=scratch,Scratch &
    sleep 0.5
    pid=$(xdotool search --class Scratch)
    echo $pid
    bspc node $pid --flag hidden -f
else
    for pid in ${pids[@]}; do
        bspc node "$pid" --flag hidden -f
    done
fi
