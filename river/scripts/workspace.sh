#!/bin/bash

while getopts g:m:s: flag; do
    case "${flag}" in
        g) 
            tag_id=$(( 1 << (OPTARG - 1) ))
            riverctl set-focused-tags "${tag_id}"
            echo $tag_id > ~/.cache/rivertag
            ;;
        m)
            tag_id=$(( (1 << (OPTARG - 1)) | "$(cat ~/.cache/rivertag)" ))
            riverctl set-view-tags $tag_id
            ;;
        s) 
            tag_id=$(( 1 << (OPTARG - 1) ))
            riverctl set-view-tags "$tag_id"
            ;;
        *) exit 1 ;;
    esac
done
