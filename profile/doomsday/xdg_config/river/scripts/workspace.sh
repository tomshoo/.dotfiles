#!/usr/bin/env sh

while getopts g:m:s:t:S: flag; do
    case "${flag}" in
    g) tag_id=$(( (1 << (OPTARG - 1)) + (1 << 30) ))
       riverctl set-focused-tags "${tag_id}"
       ;;
    m) tag_id=$(( 1 << (OPTARG - 1) ))
       riverctl toggle-view-tags $tag_id
       ;;
    s) tag_id=$(( 1 << (OPTARG - 1) ))
       riverctl set-view-tags $tag_id
       ;;
    t) tag_id=$(( 1 << (OPTARG - 1) ))
       riverctl toggle-focused-tags "${tag_id}"
       ;;
    S) tag_id=$(( 1 << (OPTARG - 1) ))
       riverctl set-view-tags "$tag_id" 
       riverctl set-focused-tags "$(( tag_id + (1 << 30) ))"
       ;;
    *) echo "Usage: $0 -[g|m|s]";
       exit 1
       ;;
    esac
done
