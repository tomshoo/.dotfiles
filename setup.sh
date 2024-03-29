#!/usr/bin/env bash
# shellcheck disable=SC2086

if [[ ! -d profile ]] || test -z "$(ls -d profile/*/)"; then
    echo "error: no profiles found..." >&2
    exit 1
fi

pkg-install() { sudo pacman -Syu --needed "$@"; }
create-link() {
    target=$2
    src=$1

    printf '%s => %s\n' "$src" "$target"
    [[ $force = false ]] && linkargs='-sfi' || linkargs='-sf'
    ln $linkargs "$src" "$target"
}

setup-fs() {
    source_fs=$1
    target_fs=$2

    [[ -z $target_fs ]] && target_fs=~

    ! [[ -d "$target_fs/.config" ]]    && mkdir -p "$target_fs/.config"
    ! [[ -d "$target_fs/.local/bin" ]] && mkdir -p "$target_fs/.local/bin"

    link-path() {
        packages=$(find "$1" -maxdepth 1 -not -wholename "$1" -printf '%p:')
        [[ "$target_fs" = "$2" ]]       &&
            target_dir="$target_fs"     ||
            target_dir="$target_fs/$2/"

        for package in $(IFS=:; echo $packages); do
            package_path="$(realpath "$package")"
            create-link "$package_path" "$target_dir"
        done
    }

    pushd "$source_fs" &>/dev/null || exit 1
    [[ -d xdg_config ]] && [[ -n "$(ls -A xdg_config)" ]] && link-path xdg_config .config
    [[ -d bin ]]        && [[ -n "$(ls -A bin)" ]]        && link-path bin        .local/bin
    [[ -d home ]]       && [[ -n "$(ls -A home)" ]]       && link-path home       ~
    popd               &>/dev/null || exit 1
}

typeset -A profiles=()
typeset    force=false

for profile in profile/*/; do
    profile_name=$(basename "$profile")
    profile_path=$(realpath "$profile")
    profiles["$profile_name"]=$profile_path
done

[[ -z "$1" ]] && exit 2
while getopts :flp: opt; do
    case $opt in
    p) profile_path="${profiles["$OPTARG"]}" ;;
    l) for profile in "${!profiles[@]}"; do
          echo "$profile"
       done
       exit 0     ;;
    f) force=true ;;
    ?) exit 2     ;;
    esac
done

if [[ -z "$profile_path" ]]; then
    echo "error: profile '$profile' does not exist..." >&2
    exit 1
fi

setup-fs "$profile_path" ~
setup-fs shared          ~
