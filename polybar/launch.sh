#!/bin/bash

monitors=(`bspc query -M --names`)

for i in ${!monitors[@]}; do
    LOGFILE=/tmp/polybar-${monitors[i]}.log

    echo "---" >> $LOGFILE
    MONITOR=${monitors[i]} polybar -c ~/.config/polybar/config.ini bar-$i 2>&1 | tee -a $LOGFILE & disown
done

echo "Bars launched..."
