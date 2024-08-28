#!/bin/bash

get_vol() {
    pactl get-source-mute @DEFAULT_SOURCE@ | grep -q no &&
    info=`pactl get-source-volume @DEFAULT_SOURCE@` &&
    vol=`grep -o [0-9][0-9]*% <<< $info | head -n1` &&
    echo $vol || echo muted
}

get_vol

pactl subscribe | grep --line-buffered -E source | while read -a report; do
    get_vol
done
