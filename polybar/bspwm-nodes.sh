#!/bin/bash

GREEN="#2fe43f"
GRAY="#696969"
CYAN="#4cdce6"
DARK_CYAN="#439da3"

fetch_title() {
    xprop 0si ' $0' WM_CLASS -id $1 |
    cut -d'"' -f2 | # extract title
    sed s/WM_CLASS:.*/untitled/g | # in case of undefined
    tr '[:upper:]' '[:lower:]' # transform to lower
}

format_nodes() {
    query='local.window.!hidden'
    focused=`bspc query -N -n -m $MONITOR`
    nodes=(`bspc query -N -n .$query.'!floating' -m $MONITOR`)
    marked_nodes=(`bspc query -N -n .$query.marked`)
    formatted=
    [ ${#nodes[@]} -gt 0 ] && echo :
    for i in ${!nodes[@]}; do
        let position=$i+1
        title=`fetch_title ${nodes[$i]}`
        if [[ ${nodes[$i]} = $focused ]]; then # focused nodes
            [[ ${marked_nodes[@]} =~ ${nodes[$i]} ]] &&
            formatted="$formatted%{F$CYAN}*$title%{F-} " ||
            formatted="$formatted%{F$GREEN}$title%{F-} "
        else # marked nodes
            [[ ${marked_nodes[@]} =~ ${nodes[$i]} ]] &&
            formatted="$formatted%{F$DARK_CYAN}*$title%{F-} " ||
            formatted="$formatted%{F$GRAY}$title%{F-} "
        fi
    done

    echo $formatted
}

hidden() {
    hidden=`bspc query -N -n .local.window.hidden -m $MONITOR | wc -l`
    [ $hidden -gt 0 ] && echo : %{F$GRAY}$hidden hidden%{F-} || echo
}

bspc subscribe report | while read -a report; do
    layout=
    bspc query -T -d | grep -q '"layout":"monocle"' &&
    layout=`format_nodes`" "`hidden` ||
    layout=`hidden`

    echo $layout
done
