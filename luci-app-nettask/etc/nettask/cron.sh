#!/bin/sh

uid=0

[ -s /etc/crontabs/root ] || flag=1 && touch /etc/crontabs/root
sed -i '/crontab/d' /etc/crontabs/root

while true
do
    b1=$(uci get nettask.@crontab[$uid].shellname)

    if [ -n "$b1" ]; then
        off=$(uci get nettask.@crontab[$uid].type)
        
        if [ "$off" = "1" ]; then

	    fen_u=$(uci get nettask.@crontab[$uid].minute)
            shi_u=$(uci get nettask.@crontab[$uid].shi)
            ri_u=$(uci get nettask.@crontab[$uid].day)
            yue_u=$(uci get nettask.@crontab[$uid].month)
            zhou_u=$(uci get nettask.@crontab[$uid].week)
            shellname=$(uci get nettask.@crontab[$uid].shellname)

            echo "${fen_u} ${shi_u} ${ri_u} ${yue_u} ${zhou_u} sh /etc/nettask/filetab/$shellname & #crontab" >> /etc/crontabs/root
        fi
    else
        break
    fi

    uid=$((uid + 1))
done
