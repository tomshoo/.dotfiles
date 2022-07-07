WALLS_DIR=$HOME/.local/share/backgrounds
walls=()
readarray -d '' walls < <(find "$WALLS_DIR" -type f -print0)

swabg_pid=$(pidof swaybg)

[ ! -z $swabg_pid ] && kill $swabg_pid

len=$(for i in ${!walls[@]}; do
    echo ${walls[$1]}
done | wc -l)

wall=${walls[$(( $RANDOM % $len ))]}
echo "swaybg --mode fill $wall"
swaybg --mode fill --image "$wall"
