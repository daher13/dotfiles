#!/bin/bash

bspc rule -a Emacs state=tiled
bspc rule -a "Main.rkt:main.rkt:PLT Redex Reduction Graph" state=floating rectangle=1000x600+0+0 center=on
bspc rule -a Chromium rectangle=1000x800+0+0 center=on
bspc rule -a mpv state=floating rectangle=1000x800+0+0 center=on
bspc rule -a Zathura state=tiled
bspc rule -a Thunar state=floating center=on
bspc rule -a feh rectangle=800x800+0+0 state=floating center=on
bspc rule -a qBittorrent state=floating center=on
