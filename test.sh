#!/bin/bash
home_dir="$HOME/.scbw"
function show_log {
	sleep 10
	./log.sh
}
show_log &
arg=""
map=""
speed=0
showall=""

if [[ $1 == "debug" ]]; then
	sed -i 's/javaDebugDisable/javaDebugPort/' ~/.scbw/bots/Zorg/bot.json
else
	sed -i 's/javaDebugPort/javaDebugDisable/' ~/.scbw/bots/Zorg/bot.json
fi

if [[ $1 == "me" ]]; then
vs="--human 1"
speed=25
showall="--show_all"
else
vs="krasi0"	
fi

if [[ $DISPLAY == "" ]]; then
arg="--headless"
#mapdir="/$home_dir/maps/BroodWar"
#map="(8)Big Game Hunters.scm"
mapdir="/$home_dir/maps/2019Season2"
map="(2)Tres Pass.scx"
else
arg="--capture_movement"
mapdir="/$home_dir/maps/"
map="manual-choose"
speed=${speed:-15}
fi
scbw.play --bots "Zorg" $vs $arg --game_speed $speed --map_dir "$mapdir" --map "$map" $showall
pkill log.sh
