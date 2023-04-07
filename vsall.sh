#!/bin/bash
home_dir="$HOME/.scbw/"
games_dir="$home_dir/games/"
sed -i 's/javaDebugPort/javaDebugDisable/' "$home_dir/bots/Zorg/bot.json"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RESET='\033[1;37m'

autoclean=0
if [[ $1 == "clean" ]]; then
	autoclean=1
	rm -rf "$games_dir"*
fi

rm vsall.res

while read -r bot; do
	while read -r did; do
		docker stop $did
	done < <(docker ps | grep starcraft | awk '{ print $1 }')
	echo -ne "${YELLOW}Zorg${RESET} vs ${CYAN}${bot}${RESET} : "
	arg="--headless"
	mapdir="/$home_dir/maps/2019Season2"
	map="(2)Tres Pass.scx"
	scbw.play --bots "Zorg" "$bot" --headless --timeout_at_frame 100000 --map_dir "$mapdir" --map "$map"  > vsall.log 2>&1
	game=$(ls "$games_dir" -t1 | head -n1)
	log="$games_dir/$game/logs_0/scores.json"
	if [[ ! -f $log ]]; then
		echo -e "${RED}FAIL${RESET}"
		echo "FAIL ${bot}" >> vsall.res
	else
		winner=$(jq '.is_winner' "$log")
		if [[ $winner == "true" ]]; then
			echo -e "${GREEN}WIN${RESET}"
			echo "WIN ${bot}" >> vsall.res
		else
			echo -e "${RED}LOST${RESET}"
			echo "LOST ${bot}" >> vsall.res
		fi
	fi
done < <(cat bots.lst | shuf)
if [[ $autoclean == 1 ]]; then
	docker container prune -f > /dev/null
fi

./res.sh
