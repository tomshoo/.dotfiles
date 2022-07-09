WALLS_DIR=$HOME/.local/share/backgrounds
walls=()
readarray -d '' walls < <(find "$WALLS_DIR" -type f -print0)

len=$(for i in ${!walls[@]}; do
    echo ${walls[$1]}
done | wc -l)

feh --bg-fill "${walls[$(( $RANDOM % $len ))]}"
