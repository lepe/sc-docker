#!/bin/bash
function results {
	while read -r bot; do
		grep "$bot" vsall.res
	done < <(./bots.race.sh | sort | grep $race | awk '{ print $2,$3,$4 }')
}

for race in "Terran" "Protoss" "Zerg" "Random"; do
	echo "------- $race ---------"
	echo "WON : "$(results | grep 'WIN' | wc -l)
	echo "LOST: "$(results | grep 'LOST' | wc -l)
done
total=$(cat vsall.res | wc -l)
win=$(grep "WIN " vsall.res | wc -l)
lost=$(grep "LOST " vsall.res | wc -l)
echo "------------------------"
echo "Total : $total"
echo "WON : $win"
echo "LOST: $lost"
