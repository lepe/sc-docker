#!/bin/bash
while read -r bot; do
	if [[ -d "$HOME/.scbw/bots/$bot" ]]; then
		race=$(jq -r ".race" "$HOME/.scbw/bots/$bot/bot.json")
		echo -e "$race\t$bot"
	else
		echo -e "MISSING\t$bot -----------------------"
	fi
done < <(cat bots.lst);
