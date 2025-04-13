#!/bin/env bash

dispositovo_opcoes=$(wpctl status | grep -m1 -A 3 Sinks | awk -F│ '{print $2}' | awk -F'.' '{print $0 $1 $2}' | awk -F\[ '{print $1}' | sed 's/  //g' | sed 's/* //g' | sed -n '/^[[:digit:]]/p' | dmenu -fn "Terminus-12" -nb "#282828" -sb "#504945" -sf "#ebdbb2" -p "Pipewire:")
echo $dispositovo_opcoes

dispositivo_numero=$(echo $dispositovo_opcoes | cut -d. -f1)

# echo $dispositivo_numero

wpctl set-default $dispositivo_numero &> /dev/null

