#!/bin/bash
cd "$HOME/.scbw/"
game=$(ls -t1 games/ | head -n1)
echo "$game"
log="logs_0"
if [[ ! -f games/$game/$log/bot.log ]]; then
	log="logs_1"
fi
if [[ $1 == "view" ]]; then
	vim games/$game/$log/bot.log
else
	tail -n1000 -f games/$game/$log/bot.log
fi
