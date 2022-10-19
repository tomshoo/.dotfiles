#!/bin/bash

while getopts g:m:s:t: flag; do
    case "${flag}" in
        g) 
            tag_id=$(( (1 << (OPTARG - 1)) + ( 1 << 30 ) ))
            riverctl set-focused-tags "${tag_id}"
            echo $tag_id > ~/.cache/rivertag
            ;;
        m)
            tag_id=$(( 1 << (OPTARG - 1) ))
            riverctl toggle-view-tags $tag_id
            ;;
        s) 
            tag_id=$(( 1 << (OPTARG - 1) ))
            riverctl set-view-tags $tag_id
            ;;
        t) 
            tag_id=$(( 1 << (OPTARG - 1) ))
            riverctl toggle-focused-tags "${tag_id}"
            ;;
        *) echo "Usage: $0 -[g|m|s]"; exit 1 ;;
    esac
done
