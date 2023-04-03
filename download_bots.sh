#!/bin/bash
while read -r bot; do
	echo "$bot"
	if [[ ! -d "$HOME/.scbw/bots/$bot" ]]; then
		next=$(grep -A1 "$bot" bots.lst | tail -n1)
		scbw.play --bots "$bot" "$next" --headless --timeout 1
	fi
done < <(cat bots.lst);
