#!/bin/bash

wid=$1
class=$2
instance=$3
consequences=$4

eval $consequences

if [[
#    $state = floating ||
    `xprop -id $wid WM_WINDOW_ROLE` =~ pop-up ||
    `xprop -id $wid _NET_WM_WINDOW_TYPE` =~ _NET_WM_WINDOW_TYPE_DIALOG ||
    `xprop -id $wid _NET_WM_WINDOW_TYPE` =~ "not found"
]]; then
    echo state=floating layer=above
fi
